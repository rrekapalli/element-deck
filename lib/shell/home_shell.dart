import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../help/help_catalog.dart';
import '../help/help_screen.dart';
import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import '../quiz/quiz_controller.dart';
import '../rooms/compare_room.dart';
import '../rooms/details_room.dart';
import '../rooms/quiz_room.dart';
import '../rooms/spectra_room.dart';
import '../rooms/table_room.dart';
import '../settings/settings_screens.dart';
import '../theme/ambient_background.dart';
import '../theme/app_brand.dart';
import '../theme/element_deck_ui.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.index});

  final int index;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final _scroll = [for (var i = 0; i < 5; i++) ScrollController()];

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    if (catalog.loading) {
      return const AppSplash(caption: 'Loading table…');
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
      QuizRoom(controller: _scroll[4]),
    ];
    const titles = ['TABLE', 'DETAILS', 'COMPARE', 'SPECTRA', 'QUIZ'];
    final topicId = HelpCatalog.roomTopics[widget.index];
    if (wide) {
      return Scaffold(
        body: Column(
          children: [
            _TitleBar(title: titles[widget.index], topicId: topicId),
            Expanded(
              child: Row(
                children: [
                  NavigationRail(
                    backgroundColor: _barColor(context),
                    selectedIndex: widget.index,
                    onDestinationSelected: _go,
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.grid_view),
                        label: Text('Table'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.science_outlined),
                        label: Text('Details'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.compare_arrows),
                        label: Text('Compare'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.graphic_eq),
                        label: Text('Spectra'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.quiz_outlined),
                        label: Text('Quiz'),
                      ),
                    ],
                    trailing: Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          tooltip: 'Settings',
                          icon: const Icon(Icons.settings),
                          onPressed: () => _openSettings(context),
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
        title: Row(
          children: [
            const AppMark(size: 36),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Element Deck',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'PERIODIC EXPLORER · ${titles[widget.index]}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Help',
            icon: const Icon(Icons.help_outline),
            onPressed: () => openHelp(context, topicId),
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.person_outline),
            onPressed: () => _openSettings(context),
          ),
        ],
      ),
      body: rooms[widget.index],
      bottomNavigationBar: NavigationBar(
        backgroundColor: _barColor(context),
        surfaceTintColor: Colors.transparent,
        selectedIndex: widget.index,
        onDestinationSelected: (i) {
          if (i == widget.index && _scroll[i].hasClients) {
            _scroll[i].animateTo(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
          _go(i);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Table'),
          NavigationDestination(
            icon: Icon(Icons.science_outlined),
            label: 'Details',
          ),
          NavigationDestination(
            icon: Icon(Icons.compare_arrows),
            label: 'Compare',
          ),
          NavigationDestination(icon: Icon(Icons.graphic_eq), label: 'Spectra'),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            label: 'Quiz',
          ),
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
      case 4:
        final quiz = context.read<QuizController>();
        final z = quiz.focusZ > 0
            ? quiz.focusZ
            : sel.elementOfTheDay().z;
        context.go('/quiz/$z');
      default:
        context.go('/');
    }
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => Scaffold(
          appBar: helpAppBar(
            context,
            title: 'Settings',
            topicId: HelpCatalog.settings,
          ),
          body: const SettingsHub(),
        ),
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.title, required this.topicId});
  final String title;
  final String topicId;

  @override
  Widget build(BuildContext context) {
    final sel = context.watch<SelectionController>();
    return Material(
      color: _barColor(context),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const AppMark(size: 32),
            const SizedBox(width: 10),
            const Text(
              'Element Deck',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
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
              tooltip: 'Help',
              icon: const Icon(Icons.help_outline),
              onPressed: () => openHelp(context, topicId),
            ),
          ],
        ),
      ),
    );
  }
}

Color _barColor(BuildContext context) {
  final chrome = Theme.of(context).extension<DeckChrome>();
  if (chrome == null || !chrome.glass) {
    return Theme.of(context).colorScheme.surface;
  }
  final dark = Theme.of(context).brightness == Brightness.dark;
  return dark
      ? Colors.white.withValues(alpha: 0.08)
      : Colors.white.withValues(alpha: 0.58);
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<CatalogController>();
    return Material(
      color: _barColor(context),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Text(
              settings.isPreview
                  ? 'Preview catalog'
                  : 'On-device · ${settings.pack.elements.length} elements · ${settings.pack.version}',
            ),
            const Spacer(),
            const Text('Element Deck'),
          ],
        ),
      ),
    );
  }
}
