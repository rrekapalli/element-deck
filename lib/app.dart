import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'account/account_controller.dart';
import 'billing/purchase_service.dart';
import 'classroom/classroom_controller.dart';
import 'data/catalog_store.dart';
import 'data/learner_database.dart';
import 'l10n/app_localizations.dart';
import 'packs/pack_service.dart';
import 'providers/catalog_controller.dart';
import 'providers/selection_controller.dart';
import 'providers/settings_controller.dart';
import 'providers/theme_controller.dart';
import 'shell/home_shell.dart';

class ElementDeckApp extends StatefulWidget {
  const ElementDeckApp({
    super.key,
    required this.db,
    required this.store,
    required this.firebaseReady,
  });

  final LearnerDatabase db;
  final CatalogStore store;
  final bool firebaseReady;

  @override
  State<ElementDeckApp> createState() => _ElementDeckAppState();
}

class _ElementDeckAppState extends State<ElementDeckApp> {
  late final ThemeController theme;
  late final SettingsController settings;
  late final CatalogController catalog;
  late final SelectionController selection;
  late final AccountController account;
  late final PackService packs;
  late final PurchaseService purchases;
  late final ClassroomController classroom;
  late final GoRouter router;
  var _ready = false;

  @override
  void initState() {
    super.initState();
    theme = ThemeController(widget.db);
    settings = SettingsController(widget.db);
    catalog = CatalogController(widget.store);
    selection = SelectionController(widget.db, catalog);
    account = AccountController(widget.db, widget.store);
    packs = PackService(widget.store, account);
    purchases = PurchaseService(account);
    classroom = ClassroomController(account);
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeShell(index: 0),
        ),
        GoRoute(
          path: '/e/:z',
          builder: (context, state) {
            final z = int.tryParse(state.pathParameters['z'] ?? '') ?? 1;
            selection.select(z);
            return const HomeShell(index: 1);
          },
        ),
        GoRoute(
          path: '/e/:z/spectra',
          builder: (context, state) {
            final z = int.tryParse(state.pathParameters['z'] ?? '') ?? 1;
            selection.select(z);
            return const HomeShell(index: 3);
          },
        ),
        GoRoute(
          path: '/compare/:a/:b',
          builder: (context, state) {
            final a = int.tryParse(state.pathParameters['a'] ?? '') ?? 6;
            final b = int.tryParse(state.pathParameters['b'] ?? '') ?? 14;
            selection.setPair(a, b);
            return const HomeShell(index: 2);
          },
        ),
      ],
    );
    _boot();
  }

  Future<void> _boot() async {
    try {
      await catalog.load(hasCoreEntitlement: false);
    } catch (e, st) {
      debugPrint('Catalog boot failed: $e\n$st');
    }
    if (mounted) setState(() => _ready = true);
    try {
      await theme.load().timeout(const Duration(seconds: 8));
      await settings.load().timeout(const Duration(seconds: 8));
      await account.load().timeout(const Duration(seconds: 8));
      if (widget.firebaseReady) {
        await account.attachFirebase();
        await purchases.init();
      }
      if (account.hasCore) {
        await packs.downloadIfEntitled();
        await catalog.reload(hasCoreEntitlement: account.hasCore);
      }
      await selection.load();
    } catch (e, st) {
      debugPrint('Prefs boot failed: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return MaterialApp(
        theme: ThemeData.dark(),
        home: const Scaffold(
          backgroundColor: Color(0xFF080C14),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Element Deck', style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    }
    return MultiProvider(
      providers: [
        Provider.value(value: widget.db),
        ChangeNotifierProvider.value(value: theme),
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: catalog),
        ChangeNotifierProvider.value(value: selection),
        ChangeNotifierProvider.value(value: account),
        Provider.value(value: packs),
        Provider.value(value: purchases),
        ChangeNotifierProvider.value(value: classroom),
      ],
      child: Consumer<ThemeController>(
        builder: (context, theme, _) {
          return MaterialApp.router(
            title: 'Element Deck',
            theme: theme.light,
            darkTheme: theme.dark,
            themeMode: theme.mode,
            routerConfig: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
