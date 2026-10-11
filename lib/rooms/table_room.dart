import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import '../theme/element_deck_ui.dart';
import '../theme/element_spectrum.dart';
import '../widgets/depth_control.dart';
import '../widgets/element_tile.dart';
import '../widgets/periodic_table.dart';

class TableRoom extends StatelessWidget {
  const TableRoom({super.key, required this.onOpenElement});

  final ValueChanged<int> onOpenElement;

  static const chips = [
    ('all', 'All'),
    ('reactive-nonmetal', 'Reactive Nonmetals'),
    ('noble-gas', 'Noble Gases'),
    ('alkali-metal', 'Alkali'),
    ('alkaline-earth', 'Alkaline Earth'),
    ('transition-metal', 'Transition'),
    ('post-transition', 'Post-transition'),
    ('metalloid', 'Metalloids'),
    ('lanthanide', 'Lanthanides'),
    ('actinide', 'Actinides'),
    ('halogen', 'Halogens'),
  ];

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    final sel = context.watch<SelectionController>();
    final tablet = ElementDeckUi.isTabletOrWider(context);
    final table = PeriodicTableView(
      pack: catalog.pack,
      selectedZ: sel.currentZ,
      search: sel.search,
      categoryFilter: sel.categoryFilter,
      onOpen: onOpenElement,
      fit: tablet,
    );

    if (tablet) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DepthControl(),
            const SizedBox(height: 8),
            const _SearchAndChips(),
            const SizedBox(height: 12),
            Expanded(child: table),
          ],
        ),
      );
    }

    final filtered = sel.filtered;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const DepthControl(),
        const SizedBox(height: 12),
        table,
        const SizedBox(height: 12),
        const _SearchAndChips(),
        const SizedBox(height: 8),
        Text(
          filtered.isEmpty
              ? 'Atomic Registry · 0 shown'
              : 'Atomic Registry · ${filtered.length} shown',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        if (filtered.isEmpty && sel.search.isNotEmpty) ...[
          Text(
            catalog.isPreview &&
                    (int.tryParse(sel.search.trim()) ?? 0) >= 1 &&
                    (int.tryParse(sel.search.trim()) ?? 0) <= 118 &&
                    catalog.pack.byZ(int.parse(sel.search.trim())) == null
                ? 'In the full pack'
                : 'No element matches "${sel.search}"',
          ),
          TextButton(onPressed: () => sel.setSearch(''), child: const Text('Clear search')),
        ],
        const SizedBox(height: 8),
        for (final e in filtered)
          ElementRowCard(
            element: e,
            selected: e.z == sel.currentZ,
            onTap: () => onOpenElement(e.z),
          ),
      ],
    );
  }
}

class _SearchAndChips extends StatelessWidget {
  const _SearchAndChips();

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    final sel = context.watch<SelectionController>();
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search element by name, symbol, or number',
          ),
          onChanged: sel.setSearch,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final chip in TableRoom.chips)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: sel.categoryFilter == chip.$1,
                    label: Text(
                      chip.$1 == 'all' ? 'All (${catalog.pack.elements.length})' : chip.$2,
                    ),
                    avatar: chip.$1 == 'all'
                        ? null
                        : CircleAvatar(
                            backgroundColor: ElementSpectrum.of(
                              chip.$1 == 'halogen' ? 'reactive-nonmetal' : chip.$1,
                            ),
                          ),
                    onSelected: (_) => sel.setCategory(chip.$1),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
