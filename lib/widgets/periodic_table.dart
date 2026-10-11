import 'package:flutter/material.dart';

import '../models/catalog.dart';
import '../models/periodic_layout.dart';
import '../theme/app_theme.dart';
import '../theme/element_spectrum.dart';

class PeriodicTableView extends StatelessWidget {
  const PeriodicTableView({
    super.key,
    required this.pack,
    required this.selectedZ,
    required this.search,
    required this.categoryFilter,
    required this.onOpen,
    this.fit = false,
  });

  final CatalogPack pack;
  final int selectedZ;
  final String search;
  final String categoryFilter;
  final ValueChanged<int> onOpen;
  final bool fit;

  @override
  Widget build(BuildContext context) {
    const gap = 2.0;
    final cellW = fit ? 52.0 : 42.0;
    final cellH = cellW * 1.18;
    final map = {for (final c in PeriodicLayout.cells) (c.row, c.col): c};
    final table = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var row = 0; row < PeriodicLayout.rows; row++) ...[
          if (row == 7)
            SizedBox(
              height: cellH * 0.4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: (cellW + gap) * 2),
                  child: Text(
                    '* Lanthanides and actinides',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var col = 0; col < PeriodicLayout.cols; col++) ...[
                  if (col > 0) const SizedBox(width: gap),
                  SizedBox(
                    width: cellW,
                    height: cellH,
                    child: _cell(context, map[(row, col)], cellW),
                  ),
                ],
              ],
            ),
          if (row != PeriodicLayout.rows - 1) const SizedBox(height: gap),
        ],
      ],
    );
    if (fit) {
      return FittedBox(fit: BoxFit.contain, alignment: Alignment.topCenter, child: table);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: table,
    );
  }

  Widget _cell(BuildContext context, PeriodicCell? slot, double width) {
    if (slot == null) return const SizedBox.shrink();
    final id = PeriodicLayout.element(slot.z)!;
    final inPack = pack.byZ(slot.z) != null;
    final match = id.matches(query: search, categoryFilter: categoryFilter);
    final selected = slot.z == selectedZ;
    final accent = ElementSpectrum.of(id.categoryId);
    final muted = Theme.of(context).hintColor;
    return Opacity(
      opacity: match ? (inPack ? 1 : 0.5) : 0.16,
      child: Material(
        color: selected ? accent.withValues(alpha: 0.18) : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () => onOpen(slot.z),
          borderRadius: BorderRadius.circular(5),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: selected ? accent : accent.withValues(alpha: 0.45),
                width: selected ? 1.6 : 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${id.z}',
                    style: Mono.of(context, size: (width * 0.22).clamp(7, 10), color: muted),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        id.symbol,
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w700,
                          fontSize: (width * 0.38).clamp(10, 18),
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
