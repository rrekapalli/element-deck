import 'package:flutter/material.dart';

import '../guides/property_guide.dart';
import '../guides/spectra_detail.dart';
import '../models/catalog.dart';
import '../providers/settings_controller.dart';

List<Widget> spectraDetailChildren({
  required BuildContext context,
  required ElementRecord element,
  required SettingsController settings,
  required String packVersion,
  required GlobalKey essayKey,
}) {
  final theme = Theme.of(context);
  final muted = theme.colorScheme.onSurface.withValues(alpha: 0.65);
  final body = theme.textTheme.bodyLarge?.copyWith(height: 1.5);
  final essay = ElementSpectra.lookup(element.z);
  final lines = [...element.spectralLines]..sort((a, b) => a.nm.compareTo(b.nm));

  return [
    Text(
      'SPECTRA  ·  REFERENCE',
      style: theme.textTheme.labelSmall?.copyWith(
        letterSpacing: 1.2,
        color: muted,
      ),
    ),
    Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          final target = essayKey.currentContext;
          if (target == null) return;
          Scrollable.ensureVisible(
            target,
            duration: settings.reducedMotion
                ? Duration.zero
                : const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            alignment: 0.02,
          );
        },
        child: Text('Jump to ${element.name}'),
      ),
    ),
    Text(spectraPrimer.title, style: theme.textTheme.headlineSmall),
    const SizedBox(height: 8),
    Text(
      spectraPrimer.lede,
      style: theme.textTheme.titleMedium?.copyWith(height: 1.4),
    ),
    for (final section in spectraPrimer.sections) ...[
      const SizedBox(height: 18),
      Text(section.heading, style: theme.textTheme.titleMedium),
      const SizedBox(height: 8),
      for (final paragraph in section.paragraphs) ...[
        Text(paragraph, style: body),
        const SizedBox(height: 12),
      ],
    ],
    const SizedBox(height: 8),
    Divider(color: theme.colorScheme.outline.withValues(alpha: 0.35)),
    const SizedBox(height: 16),
    Text(
      '${element.name} spectrum',
      key: essayKey,
      style: theme.textTheme.headlineSmall,
    ),
    const SizedBox(height: 8),
    Text(
      '${element.symbol}  ·  Z = ${element.z}  ·  ${element.categoryLabel}',
      style: theme.textTheme.labelSmall?.copyWith(
        letterSpacing: 0.6,
        color: muted,
      ),
    ),
    const SizedBox(height: 12),
    if (essay == null)
      Text(
        'A spectrum essay for ${element.name} is not written yet.',
        style: body,
      )
    else ...[
      Text(
        essay.lede,
        style: theme.textTheme.titleMedium?.copyWith(height: 1.4),
      ),
      for (final section in essay.sections) ...[
        const SizedBox(height: 18),
        Text(section.heading, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final paragraph in section.paragraphs) ...[
          Text(paragraph, style: body),
          const SizedBox(height: 12),
        ],
      ],
    ],
    const SizedBox(height: 8),
    Text('Lines stored for ${element.name}', style: theme.textTheme.titleMedium),
    const SizedBox(height: 8),
    if (lines.isEmpty)
      Text(
        'This pack does not store a teaching selection of lines for ${element.name}. '
        'That is a gap in the card, not a claim that the atom has no spectrum. '
        'The essay above is about the spectrum itself.',
        style: body,
      )
    else ...[
      Text(
        'These are the persistent lines the pack keeps for the strip. '
        'A research atlas of ${element.name} is longer. '
        'Each row is one jump, printed the way the Spectra tab prints it.',
        style: body,
      ),
      const SizedBox(height: 8),
      for (final line in lines) ...[
        Text(_storedLineReading(line), style: body),
        const SizedBox(height: 12),
      ],
    ],
    if (element.glow != null) ...[
      const SizedBox(height: 8),
      Text('Discharge color', style: theme.textTheme.titleMedium),
      const SizedBox(height: 8),
      Text(
        element.glow!.text,
        style: body,
      ),
      if (element.glow!.kv != null) ...[
        const SizedBox(height: 8),
        Text(
          'The teaching note quotes ${element.glow!.kv} as a flavor of the tube voltage. '
          'That voltage accelerates electrons. It is not the photon energy of a line. '
          'The photons that come out still have the energies above, a few electronvolts, not the kilovolts across the tube.',
          style: body,
        ),
      ],
      const SizedBox(height: 12),
    ],
    if (element.astro != null) ...[
      Text('Beyond the laboratory', style: theme.textTheme.titleMedium),
      const SizedBox(height: 8),
      Text(element.astro!, style: body),
      const SizedBox(height: 12),
    ],
    Text(
      'Teaching reference. Pack $packVersion. '
      'The figures in the line list belong to the bundled dataset. '
      'This page explains them. It is not a measurement the phone has made, '
      'and it is not a match score against a star.',
      style: theme.textTheme.bodySmall?.copyWith(color: muted, height: 1.45),
    ),
  ];
}

String _storedLineReading(SpectralLine line) {
  final window = line.nm < 380
      ? 'shorter than the visible window, in the ultraviolet'
      : line.nm > 780
      ? 'longer than the visible window, in the infrared'
      : 'inside the visible window the strip draws, from 380 to 780 nm';
  final role = switch (line.spectrum) {
    'emission' => 'The pack quotes it as an emission line.',
    'absorption' => 'The pack quotes it as an absorption line.',
    _ =>
      'The pack quotes it for both emission and absorption. The wavelength is the same either way. Only the direction of the jump changes.',
  };
  final assignment = line.transition.trim().isEmpty
      ? 'No assignment string is stored with it.'
      : 'The assignment stored with it is ${line.transition}.';
  final nm = line.nm.toStringAsFixed(2);
  final energy = line.eV.toStringAsFixed(2);
  final freq = (line.frequencyHz / 1e12).toStringAsFixed(2);
  return '$nm nm · $energy eV · $freq THz · ${line.color}. '
      'The line lies $window. $assignment $role '
      'That energy is the gap between two levels, not the work of ionizing the atom, unless the upper level is the ionization limit.';
}
