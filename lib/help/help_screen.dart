import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'help_catalog.dart';
import 'help_content_loader.dart';
import 'help_document.dart';

/// Opens the user guide on [topicId]. Previous and Next walk [HelpCatalog].
void openHelp(BuildContext context, String topicId) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => HelpScreen(initialTopicId: topicId),
    ),
  );
}

/// App bar used by settings pages: title plus the help button for that page.
AppBar helpAppBar(
  BuildContext context, {
  required String title,
  required String topicId,
}) {
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
        tooltip: 'Help',
        icon: const Icon(Icons.help_outline),
        onPressed: () => openHelp(context, topicId),
      ),
    ],
  );
}

/// In-app user guide for one page, with Previous and Next at the bottom.
class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key, required this.initialTopicId});

  final String initialTopicId;

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  /// Wide pane: guide on the left, screenshots on the right.
  static const _twoColumnMinWidth = 600.0;

  late String _topicId;
  String? _markdown;
  bool _loading = true;
  String? _loadedKey;

  @override
  void initState() {
    super.initState();
    final initial = HelpCatalog.topicById(widget.initialTopicId);
    _topicId = initial?.id ??
        (HelpCatalog.guideOrder.isNotEmpty
            ? HelpCatalog.guideOrder.first.id
            : widget.initialTopicId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadIfNeeded();
  }

  void _loadIfNeeded() {
    if (_loadedKey == _topicId && _markdown != null) return;
    _load(_topicId);
  }

  Future<void> _load(String topicId) async {
    const unavailable = 'Help is unavailable for this screen.';
    if (!_loading) {
      setState(() => _loading = true);
    }
    final markdown = await HelpContentLoader.loadMarkdown(
      topicId: topicId,
      unavailableMessage: unavailable,
    );
    if (!mounted || topicId != _topicId) return;
    setState(() {
      _markdown = markdown;
      _loading = false;
      _loadedKey = topicId;
    });
  }

  void _goTo(HelpTopic? topic) {
    if (topic == null) return;
    setState(() {
      _topicId = topic.id;
      _loading = true;
      _markdown = null;
      _loadedKey = null;
    });
    _load(topic.id);
  }

  Widget _imageBuilder(Uri uri, String? title, String? alt) {
    final path = _resolveAssetPath(uri);
    if (path == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: _helpScreenshot(path),
    );
  }

  Widget _helpScreenshot(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }

  /// Supports `asset:assets/help/images/foo.png` and bare asset paths.
  static String? _resolveAssetPath(Uri uri) {
    final raw = uri.toString();
    if (raw.startsWith('asset:')) {
      final path = raw.substring('asset:'.length);
      return path.isEmpty ? null : path;
    }
    if (raw.startsWith('assets/')) return raw;
    return null;
  }

  MarkdownStyleSheet _styleSheet(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurface;
    final soft = color.withValues(alpha: 0.72);
    return MarkdownStyleSheet.fromTheme(theme).copyWith(
      h1: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w800,
        height: 1.3,
      ),
      h2: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      h2Padding: const EdgeInsets.only(top: 22, bottom: 8),
      h3: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      h3Padding: const EdgeInsets.only(top: 14, bottom: 6),
      p: theme.textTheme.bodyLarge?.copyWith(height: 1.55, color: color),
      pPadding: const EdgeInsets.only(bottom: 10),
      listBullet: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
      listIndent: 22,
      blockSpacing: 8,
      em: theme.textTheme.bodyMedium?.copyWith(
        fontStyle: FontStyle.italic,
        height: 1.45,
        color: soft,
      ),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(top: BorderSide(color: color.withValues(alpha: 0.12))),
      ),
    );
  }

  Widget _markdownView(String data, {EdgeInsets? padding}) {
    return Markdown(
      data: data,
      selectable: true,
      padding: padding ?? const EdgeInsets.fromLTRB(20, 16, 20, 24),
      styleSheet: _styleSheet(context),
      imageBuilder: _imageBuilder,
    );
  }

  List<Widget> _heroChildren(HelpDocument doc) {
    final soft = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.72);
    return [
      for (final img in doc.images) ...[
        _helpScreenshot(img.assetPath),
        const SizedBox(height: 12),
      ],
      if (doc.imageCaption != null)
        MarkdownBody(
          data: doc.imageCaption!,
          selectable: true,
          styleSheet: _styleSheet(context).copyWith(
            p: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13,
              height: 1.45,
              color: soft,
            ),
          ),
        ),
    ];
  }

  Widget _heroPane(HelpDocument doc) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _heroChildren(doc),
      ),
    );
  }

  Widget _body(HelpDocument doc) {
    final source = _markdown ?? 'Help is unavailable for this screen.';
    if (!doc.hasHeroImages) {
      return _markdownView(source);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoCol = constraints.maxWidth >= _twoColumnMinWidth;
        if (!twoCol) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MarkdownBody(
                  data: doc.bodyMarkdown,
                  selectable: true,
                  styleSheet: _styleSheet(context),
                  imageBuilder: _imageBuilder,
                ),
                const SizedBox(height: 20),
                ..._heroChildren(doc),
              ],
            ),
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 11,
              child: _markdownView(
                doc.bodyMarkdown,
                padding: const EdgeInsets.fromLTRB(24, 16, 16, 28),
              ),
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface.withValues(
                alpha: 0.08,
              ),
            ),
            Expanded(flex: 9, child: _heroPane(doc)),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loadedKey != _topicId && !_loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadIfNeeded();
      });
    }

    final topic = HelpCatalog.topicById(_topicId);
    final prev = HelpCatalog.previous(_topicId);
    final next = HelpCatalog.next(_topicId);
    final heading = HelpContentLoader.headingFromMarkdown(_markdown);
    final topicLabel = heading ?? topic?.title;
    final title = topicLabel == null ? 'Help' : 'Help: $topicLabel';
    final doc = HelpDocument.parse(_markdown ?? '');

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _body(doc),
          ),
          SafeArea(
            top: false,
            child: Material(
              elevation: 6,
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: prev == null ? null : () => _goTo(prev),
                        icon: const Icon(Icons.chevron_left_rounded),
                        label: const Text('Previous'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: next == null ? null : () => _goTo(next),
                        icon: const Icon(Icons.chevron_right_rounded),
                        label: const Text('Next'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
