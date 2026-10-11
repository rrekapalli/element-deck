import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import '../rooms/compare_room.dart';
import '../rooms/details_room.dart';
import '../rooms/spectra_room.dart';
import '../rooms/table_room.dart';
import '../settings/settings_screens.dart';
import '../theme/element_deck_ui.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.index});

  final int index;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final _scroll = [for (var i = 0; i < 4; i++) ScrollController()];

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    if (catalog.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (catalog.error != null && catalog.pack.elements.isEmpty) {
      return Scaffold(body: Center(child: Text(catalog.error!)));
    }
    final wide = ElementDeckUi.isWideShell(context);
    final rooms = [
      TableRoom(
        onOpenElement: (z) {
          context.read<SelectionController>().select(z);
          context.go('/e/$z');
        },
      ),
      const DetailsRoom(),
      const CompareRoom(),
      const SpectraRoom(),
    ];
    final titles = ['TABLE', 'DETAILS', 'COMPARE', 'SPECTRA'];
    if (wide) {
      return Scaffold(
        body: Column(
          children: [
            _TitleBar(title: titles[widget.index]),
            Expanded(
              child: Row(
                children: [
                  NavigationRail(
                    selectedIndex: widget.index,
                    onDestinationSelected: _go,
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(icon: Icon(Icons.grid_view), label: Text('Table')),
                      NavigationRailDestination(icon: Icon(Icons.science_outlined), label: Text('Details')),
                      NavigationRailDestination(icon: Icon(Icons.compare_arrows), label: Text('Compare')),
                      NavigationRailDestination(icon: Icon(Icons.graphic_eq), label: Text('Spectra')),
                    ],
                    trailing: Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          tooltip: 'Settings',
                          icon: const Icon(Icons.settings),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Scaffold(
                                appBar: AppBar(title: const Text('Settings')),
                                body: const SettingsHub(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: rooms[widget.index]),
                ],
              ),
            ),
            const _Footer(),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Element Deck'),
            Text(
              'PERIODIC EXPLORER · ${titles[widget.index]}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _filter(context),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBar(title: const Text('Settings')),
                  body: const SettingsHub(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: rooms[widget.index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.index,
        onDestinationSelected: (i) {
          if (i == widget.index && _scroll[i].hasClients) {
            _scroll[i].animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
          }
          _go(i);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Table'),
          NavigationDestination(icon: Icon(Icons.science_outlined), label: 'Details'),
          NavigationDestination(icon: Icon(Icons.compare_arrows), label: 'Compare'),
          NavigationDestination(icon: Icon(Icons.graphic_eq), label: 'Spectra'),
        ],
      ),
    );
  }

  void _go(int i) {
    final sel = context.read<SelectionController>();
    switch (i) {
      case 1:
        context.go('/e/${sel.currentZ}');
      case 2:
        context.go('/compare/${sel.compareA}/${sel.compareB}');
      case 3:
        context.go('/e/${sel.currentZ}/spectra');
      default:
        context.go('/');
    }
  }

  void _filter(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Use category chips on Table to filter by family, including Halogen as a tag.'),
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final sel = context.watch<SelectionController>();
    return Material(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Text('Element Deck', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(width: 16),
            Text(title),
            const Spacer(),
            SizedBox(
              width: 280,
              child: TextField(
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: sel.setSearch,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpPage())),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<CatalogController>();
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Text(settings.isPreview ? 'Preview · on this device' : 'Pack ${settings.pack.version}'),
            const Spacer(),
            const Text('Element Deck'),
          ],
        ),
      ),
    );
  }
}
