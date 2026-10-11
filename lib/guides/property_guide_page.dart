import 'package:flutter/material.dart';

import 'property_guide.dart';

void openPropertyGuide(BuildContext context, String id) {
  final guide = PropertyGuides.lookup(id);
  assert(guide != null, 'Missing property guide: $id');
  if (guide == null) return;
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => PropertyGuidePage(guide: guide)),
  );
}

class PropertyGuidePage extends StatelessWidget {
  const PropertyGuidePage({super.key, required this.guide});

  final PropertyGuide guide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurface.withValues(alpha: 0.65);
    final body = theme.textTheme.bodyLarge?.copyWith(height: 1.5);
    return Scaffold(
      appBar: AppBar(title: Text(guide.title)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SelectionArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
              children: [
                Text(
                  '${guide.group.toUpperCase()}  ·  REFERENCE',
                  style: theme.textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.2,
                    color: muted,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  guide.lede,
                  style: theme.textTheme.titleMedium?.copyWith(height: 1.4),
                ),
                const SizedBox(height: 8),
                for (final section in guide.sections) ...[
                  const SizedBox(height: 18),
                  Text(section.heading, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  for (final paragraph in section.paragraphs) ...[
                    Text(paragraph, style: body),
                    const SizedBox(height: 12),
                  ],
                ],
                const SizedBox(height: 12),
                Text(
                  guide.closing ??
                      'Teaching reference. The figure beside this label comes from '
                          'the bundled dataset and is shown in the units chosen in App '
                          'Config. This article explains the property. It is not a new '
                          'measurement of the element.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: muted,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
