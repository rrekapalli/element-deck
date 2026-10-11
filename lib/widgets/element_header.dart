import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/catalog.dart';
import '../providers/selection_controller.dart';
import '../theme/app_theme.dart';
import '../theme/element_spectrum.dart';

/// Pins [ElementHeader] and lets [child] scroll beneath it.
class ElementDossier extends StatelessWidget {
  const ElementDossier({super.key, required this.element, required this.child});

  final ElementRecord element;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: theme.scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ElementHeader(element: element),
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
    final accent = ElementSpectrum.of(element.categoryId);
    final sel = context.watch<SelectionController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (element.isotopes.isNotEmpty)
          Text(
            _isotopeTeaser(element),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              element.symbol,
              style: Theme.of(context).textTheme.displayMedium
                  ?.copyWith(color: accent, fontWeight: FontWeight.w800),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${element.z}  ${element.name}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '${element.atomicWeight} u · ${element.weightKind}',
                    style: Mono.of(context, size: 12),
                  ),
                  Text(
                    '${element.categoryLabel} · ${element.block}-block · Period ${element.period} · Grp ${element.group ?? "—"}',
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                sel.bookmarks.contains(element.z)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () => sel.toggleBookmark(element.z),
            ),
          ],
        ),
      ],
    );
  }
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
