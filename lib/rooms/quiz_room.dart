import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../account/account_controller.dart';
import '../models/catalog.dart';
import '../providers/selection_controller.dart';
import '../providers/settings_controller.dart';
import '../quiz/quiz_controller.dart';
import '../quiz/quiz_models.dart';
import '../theme/ambient_background.dart';
import '../theme/element_spectrum.dart';
import '../widgets/course_paywall.dart';

class QuizRoom extends StatefulWidget {
  const QuizRoom({super.key, this.controller});

  final ScrollController? controller;

  @override
  State<QuizRoom> createState() => _QuizRoomState();
}

class _QuizRoomState extends State<QuizRoom> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ensurePool();
  }

  void _ensurePool() {
    final quiz = context.read<QuizController>();
    final settings = context.read<SettingsController>();
    final selected = context.read<SelectionController>().currentZ;
    final z = quiz.focusZ > 0 ? quiz.focusZ : selected;
    if (z <= 0 || quiz.loading) return;
    if (quiz.isLoaded(z, settings.depth)) return;
    if (quiz.error != null && quiz.focusZ == z) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final q = context.read<QuizController>();
      final depth = context.read<SettingsController>().depth;
      final next = q.focusZ > 0
          ? q.focusZ
          : context.read<SelectionController>().currentZ;
      q.open(z: next, depth: depth);
    });
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizController>();
    final settings = context.watch<SettingsController>();
    final account = context.watch<AccountController>();
    _ensurePool();

    final mode = switch (settings.depth) {
      'beginner' => 'Beginner',
      'advanced' => 'Advanced',
      _ => 'Intermediate',
    };
    final body = ListView(
      controller: widget.controller,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        _ChangeElementButton(quiz: quiz),
        const SizedBox(height: 12),
        _StatsRow(quiz: quiz),
        const SizedBox(height: 4),
        Text(
          '$mode pool · change learning mode in App Config',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 12),
        if (account.hasCore && !account.ownsDepth(settings.depth))
          CoursePaywall(depth: settings.depth)
        else if (quiz.element == null)
          const Text('This element is not in the on-device catalog.')
        else if (!quiz.element!.hasLesson && !account.hasCore)
          CoursePaywall(
            depth: settings.depth,
            message:
                'Quiz pools ship with each course pack. The five preview elements stay free.',
          )
        else ...[
          _ProgressLine(quiz: quiz),
          const SizedBox(height: 12),
          if (quiz.loading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (quiz.error != null) ...[
            Text(quiz.error!),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => quiz.useElement(quiz.focusZ, settings.depth),
              child: const Text('Retry'),
            ),
          ] else if (quiz.current == null)
            const Text('No questions in this pool.')
          else ...[
            if (quiz.complete) ...[
              _CompleteCard(quiz: quiz),
              const SizedBox(height: 16),
            ],
            _QuestionBlock(quiz: quiz),
          ],
          const SizedBox(height: 16),
          _ToolsRow(quiz: quiz),
          const SizedBox(height: 20),
          _BankCard(quiz: quiz),
        ],
      ],
    );

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: body,
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.quiz});
  final QuizController quiz;

  @override
  Widget build(BuildContext context) {
    final chrome = Theme.of(context).extension<DeckChrome>();
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      children: [
        const Icon(Icons.local_fire_department, color: Color(0xFFF59E0B), size: 20),
        const SizedBox(width: 6),
        Text(
          '${quiz.streak}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 6),
        Text('streak', style: TextStyle(color: muted, fontSize: 12)),
        const Spacer(),
        Icon(Icons.bolt, color: chrome?.accent ?? const Color(0xFF38BDF8), size: 20),
        const SizedBox(width: 4),
        Text(
          _formatXp(quiz.xp),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 6),
        Text('XP', style: TextStyle(color: muted, fontSize: 12)),
        const SizedBox(width: 12),
        Text('Tier: ${quiz.tierName}', style: TextStyle(color: muted, fontSize: 12)),
      ],
    );
  }
}

String _formatXp(int n) {
  final s = n.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return buf.toString();
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({required this.quiz});
  final QuizController quiz;

  @override
  Widget build(BuildContext context) {
    final total = quiz.pool.isEmpty ? QuizController.poolSize : quiz.pool.length;
    final n = quiz.pool.isEmpty ? 0 : quiz.index + 1;
    final pct = total == 0 ? 0.0 : quiz.answeredCount / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              tooltip: 'Previous question',
              onPressed: quiz.hasPrevious ? quiz.previous : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                'Question $n / $total',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            IconButton(
              tooltip: 'Next question',
              onPressed: quiz.hasNext ? quiz.next : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        Text(
          '${(pct * 100).round()}% answered',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 6,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.25),
          ),
        ),
      ],
    );
  }
}

class _QuestionBlock extends StatelessWidget {
  const _QuestionBlock({required this.quiz});
  final QuizController quiz;

  @override
  Widget build(BuildContext context) {
    final q = quiz.current;
    if (q == null) return const SizedBox.shrink();
    final locked = quiz.picked != null || quiz.answered.containsKey(q.id);
    final chosen = quiz.picked;
    final already = quiz.answered[q.id];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
              ),
              child: Text(
                q.categoryLabel.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const Spacer(),
            Text(
              '+${QuizController.xpPerCorrect} XP',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          q.stem,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < q.options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _OptionTile(
              key: ValueKey('quiz-option-$i'),
              letter: String.fromCharCode(65 + i),
              text: q.options[i],
              locked: locked,
              selected: chosen == i,
              isCorrect: i == q.correctIndex,
              onTap: locked ? null : () => quiz.choose(i),
            ),
          ),
        if (locked) ...[
          const SizedBox(height: 8),
          _ExplainCard(
            correct: already == true ||
                (chosen != null && chosen == q.correctIndex),
            question: q,
          ),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: quiz.hasPrevious ? quiz.previous : null,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Previous'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: quiz.hasNext ? quiz.next : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  quiz.hasNext
                      ? 'Next (${quiz.index + 1} / ${quiz.pool.length})'
                      : 'Last question',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    super.key,
    required this.letter,
    required this.text,
    required this.locked,
    required this.selected,
    required this.isCorrect,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool locked;
  final bool selected;
  final bool isCorrect;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF22C55E);
    final red = const Color(0xFFEF4444);
    Color? fill;
    Color? border;
    if (locked && isCorrect) {
      fill = green.withValues(alpha: 0.16);
      border = green;
    } else if (locked && selected && !isCorrect) {
      fill = red.withValues(alpha: 0.12);
      border = red;
    }
    return Material(
      color: fill ?? Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  border ??
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                letter,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: border ?? Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(text)),
              if (locked && isCorrect)
                Icon(Icons.check_circle, color: green, size: 20),
              if (locked && selected && !isCorrect)
                Icon(Icons.cancel, color: red, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExplainCard extends StatelessWidget {
  const _ExplainCard({required this.correct, required this.question});
  final bool correct;
  final QuizQuestion question;

  @override
  Widget build(BuildContext context) {
    final color = correct ? const Color(0xFF22C55E) : const Color(0xFFEF4444);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.45)),
        color: color.withValues(alpha: 0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            correct
                ? 'Correct! (+${QuizController.xpPerCorrect} XP)'
                : 'Not this time',
            style: TextStyle(color: color, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(question.explanation),
          if (question.equation != null) ...[
            const SizedBox(height: 10),
            Text(
              question.equation!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'JetBrains Mono',
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CompleteCard extends StatelessWidget {
  const _CompleteCard({required this.quiz});
  final QuizController quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pool complete',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${quiz.correctInPool} / ${quiz.pool.length} correct · '
            '${quiz.correctInPool * QuizController.xpPerCorrect} XP from this pool',
          ),
          const SizedBox(height: 8),
          Text('Tier: ${quiz.tierName}'),
        ],
      ),
    );
  }
}

class _ToolsRow extends StatelessWidget {
  const _ToolsRow({required this.quiz});
  final QuizController quiz;

  @override
  Widget build(BuildContext context) {
    final sel = context.watch<SelectionController>();
    final bookmarked = sel.bookmarks.contains(quiz.focusZ);
    return Row(
      children: [
        TextButton.icon(
          onPressed: () => _note(context, quiz),
          icon: const Icon(Icons.edit_note, size: 18),
          label: const Text('Notes'),
        ),
        TextButton.icon(
          onPressed: () => sel.toggleBookmark(quiz.focusZ),
          icon: Icon(bookmarked ? Icons.bookmark : Icons.bookmark_border, size: 18),
          label: const Text('Bookmark'),
        ),
        TextButton.icon(
          onPressed: quiz.current == null ? null : () => _report(context, quiz),
          icon: const Icon(Icons.flag_outlined, size: 18),
          label: const Text('Report'),
        ),
      ],
    );
  }

  Future<void> _note(BuildContext context, QuizController quiz) async {
    final controller = TextEditingController(text: quiz.note);
    final value = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Notes'),
        content: TextField(
          controller: controller,
          maxLines: 6,
          decoration: const InputDecoration(
            hintText: 'Private notes for this element',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value != null) await quiz.saveNote(value);
  }

  Future<void> _report(BuildContext context, QuizController quiz) async {
    final controller = TextEditingController();
    final value = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Report question'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'What is wrong? Stored on this device only.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Save locally'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value != null) {
      await quiz.report(value);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report saved on this device.')),
        );
      }
    }
  }
}

class _BankCard extends StatelessWidget {
  const _BankCard({required this.quiz});
  final QuizController quiz;

  @override
  Widget build(BuildContext context) {
    final bars = quiz.categoryBars();
    if (bars.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active element bank',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '${quiz.pool.length} questions · ${quiz.tierName} pool',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 10),
        for (final e in bars.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    quizCategoryLabel(e.key),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: e.value.$2 == 0 ? 0 : e.value.$1 / e.value.$2,
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 40,
                  child: Text(
                    '${e.value.$1}/${e.value.$2}',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ChangeElementButton extends StatelessWidget {
  const _ChangeElementButton({required this.quiz});
  final QuizController quiz;

  @override
  Widget build(BuildContext context) {
    final element = quiz.element;
    return OutlinedButton.icon(
      onPressed: () => _pick(context, quiz),
      icon: const Icon(Icons.swap_horiz),
      label: Text(
        element == null
            ? 'Change element'
            : 'Change element · ${element.name}',
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _pick(BuildContext context, QuizController quiz) async {
    final z = await showDialog<int>(
      context: context,
      builder: (ctx) => _ElementPickerDialog(
        elements: quiz.pack.elements,
        currentZ: quiz.focusZ,
      ),
    );
    if (z == null || !context.mounted) return;
    final depth = context.read<SettingsController>().depth;
    await context.read<SelectionController>().select(z);
    await quiz.useElement(z, depth);
    if (context.mounted) context.go('/quiz/$z');
  }
}

class _ElementPickerDialog extends StatefulWidget {
  const _ElementPickerDialog({
    required this.elements,
    required this.currentZ,
  });

  final List<ElementRecord> elements;
  final int currentZ;

  @override
  State<_ElementPickerDialog> createState() => _ElementPickerDialogState();
}

class _ElementPickerDialogState extends State<_ElementPickerDialog> {
  final _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  List<ElementRecord> get _filtered {
    final q = _query.text.trim().toLowerCase();
    if (q.isEmpty) return widget.elements;
    final asZ = int.tryParse(q);
    return widget.elements.where((e) {
      if (asZ != null && e.z == asZ) return true;
      if (e.symbol.toLowerCase() == q) return true;
      if (e.name.toLowerCase().contains(q)) return true;
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hits = _filtered;
    return AlertDialog(
      title: const Text('Change element'),
      content: SizedBox(
        width: 420,
        height: 420,
        child: Column(
          children: [
            TextField(
              controller: _query,
              autofocus: true,
              decoration: const InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search name, symbol, or number',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: hits.isEmpty
                  ? const Center(child: Text('No element matches.'))
                  : ListView.builder(
                      itemCount: hits.length,
                      itemBuilder: (context, i) {
                        final e = hits[i];
                        final accent = ElementSpectrum.of(e.categoryId);
                        return ListTile(
                          selected: e.z == widget.currentZ,
                          leading: Text(
                            e.symbol,
                            style: TextStyle(
                              color: accent,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          title: Text(e.name),
                          subtitle: Text('Z ${e.z} · ${e.categoryLabel}'),
                          onTap: () => Navigator.pop(context, e.z),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
