import 'dart:math' as math;

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
  });

  final CatalogPack pack;
  final int selectedZ;
  final String search;
  final String categoryFilter;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth.isFinite && constraints.maxWidth > 0
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width - 32;
        final maxH = constraints.maxHeight.isFinite && constraints.maxHeight > 40
            ? constraints.maxHeight
            : math.max(220.0, maxW * 0.52);
        const gap = 2.0;
        const labelH = 16.0;
        // 7 main periods + 2 f-block rows
        const bodyRows = 9;
        var cellW = (maxW - gap * (PeriodicLayout.cols - 1)) / PeriodicLayout.cols;
        var cellH = (maxH - labelH - gap * bodyRows) / bodyRows;
        cellW = math.max(18.0, math.min(cellW, cellH / 1.05));
        cellH = math.max(22.0, math.min(cellH, cellW * 1.25));
        final map = {for (final c in PeriodicLayout.cells) (c.row, c.col): c};

        Widget rowOf(int row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var col = 0; col < PeriodicLayout.cols; col++) ...[
                if (col > 0) const SizedBox(width: gap),
                SizedBox(
                  width: cellW,
                  height: cellH,
                  child: _Cell(
                    slot: map[(row, col)],
                    pack: pack,
                    selectedZ: selectedZ,
                    search: search,
                    categoryFilter: categoryFilter,
                    onOpen: onOpen,
                    width: cellW,
                  ),
                ),
              ],
            ],
          );
        }

        final table = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var row = 0; row <= 6; row++) ...[
              rowOf(row),
              const SizedBox(height: gap),
            ],
            SizedBox(
              height: labelH,
              child: Padding(
                padding: EdgeInsets.only(left: (cellW + gap) * 2),
                child: Text(
                  'Lanthanides · Actinides',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            rowOf(PeriodicLayout.lanthanideRow),
            const SizedBox(height: gap),
            rowOf(PeriodicLayout.actinideRow),
          ],
        );

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: table,
          ),
        );
      },
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.slot,
    required this.pack,
    required this.selectedZ,
    required this.search,
    required this.categoryFilter,
    required this.onOpen,
    required this.width,
  });

  final PeriodicCell? slot;
  final CatalogPack pack;
  final int selectedZ;
  final String search;
  final String categoryFilter;
  final ValueChanged<int> onOpen;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (slot == null) return const SizedBox.shrink();
    final id = PeriodicLayout.element(slot!.z)!;
    final inPack = pack.byZ(slot!.z) != null;
    final match = id.matches(query: search, categoryFilter: categoryFilter);
    final selected = slot!.z == selectedZ;
    final accent = ElementSpectrum.of(id.categoryId);
    final muted = Theme.of(context).hintColor;
    final zSize = (width * 0.22).clamp(6.0, 10.0);
    final symSize = (width * 0.36).clamp(8.0, 16.0);
    return Opacity(
      opacity: match ? (inPack ? 1 : 0.45) : 0.14,
      child: Material(
        color: selected ? accent.withValues(alpha: 0.2) : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () => onOpen(slot!.z),
          borderRadius: BorderRadius.circular(4),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: selected ? accent : accent.withValues(alpha: 0.5),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${id.z}', style: Mono.of(context, size: zSize, color: muted), maxLines: 1),
                  Expanded(
                    child: Center(
                      child: Text(
                        id.symbol,
                        maxLines: 1,
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w700,
                          fontSize: symSize,
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
