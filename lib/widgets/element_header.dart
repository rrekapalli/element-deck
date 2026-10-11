import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/catalog.dart';
import '../providers/selection_controller.dart';
import '../theme/app_theme.dart';
import '../theme/element_spectrum.dart';

/// Pins [ElementHeader] and lets [child] scroll beneath it.
///
/// [pinned] stays with the header. Details uses it for the tab bar.
class ElementDossier extends StatelessWidget {
  const ElementDossier({
    super.key,
    required this.element,
    required this.child,
    this.pinned,
  });

  final ElementRecord element;
  final Widget child;
  final Widget? pinned;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 8, 0),
                child: ElementHeader(element: element),
              ),
              ?pinned,
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.35),
        ),
        Expanded(child: child),
      ],
    );
  }
}

/// Identity block shared by Details and Spectra: isotope line, symbol, name, mass, classification.
class ElementHeader extends StatelessWidget {
  const ElementHeader({super.key, required this.element});

  final ElementRecord element;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = ElementSpectrum.of(element.categoryId);
    final sel = context.watch<SelectionController>();
    final muted = theme.colorScheme.onSurface.withValues(alpha: 0.72);
    final meta = theme.textTheme.labelSmall?.copyWith(
      color: muted,
      height: 1.2,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          element.symbol,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: accent,
            fontWeight: FontWeight.w800,
            fontSize: 28,
            height: 1,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${element.z}  ${element.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${element.atomicWeight} u · ${element.weightKind}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Mono.of(context, size: 11, color: muted),
              ),
              _oneLine(
                '${element.categoryLabel} · ${element.block}-block · Period ${element.period} · Grp ${element.group ?? "—"}',
                meta,
              ),
              if (element.isotopes.isNotEmpty)
                _oneLine(_isotopeTeaser(element), meta),
            ],
          ),
        ),
        IconButton(
          style: IconButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(32, 32),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          icon: Icon(
            sel.bookmarks.contains(element.z)
                ? Icons.bookmark
                : Icons.bookmark_border,
            size: 20,
          ),
          onPressed: () => sel.toggleBookmark(element.z),
        ),
      ],
    );
  }
}

/// Keeps a meta line on one row, shrinking only when the phone is too narrow.
Widget _oneLine(String text, TextStyle? style) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    alignment: Alignment.centerLeft,
    child: Text(text, maxLines: 1, softWrap: false, style: style),
  );
}

String _isotopeTeaser(ElementRecord e) {
  final iso = e.isotopes.first;
  final kind = iso.stability == 'stable' ? 'Stable isotope' : 'Isotope';
  return '$kind · ${iso.a}${e.symbol}  (${_percent(iso.abundance)})';
}

String _percent(double? abundance) {
  if (abundance == null) return 'abundance not reported';
  final pct = abundance * 100;
  if (pct >= 1) return '${pct.toStringAsFixed(2)}%';
  if (pct >= 0.01) return '${pct.toStringAsFixed(3)}%';
  return '${pct.toStringAsFixed(4)}%';
}
