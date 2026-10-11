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
import 'pwa/pwa_update_banner.dart';
import 'pwa/pwa_update_service.dart';
import 'pwa/web_foreground.dart';
import 'providers/catalog_controller.dart';
import 'providers/selection_controller.dart';
import 'providers/settings_controller.dart';
import 'providers/theme_controller.dart';
import 'shell/home_shell.dart';
import 'theme/ambient_background.dart';
import 'theme/app_brand.dart';

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

class _ElementDeckAppState extends State<ElementDeckApp>
    with WidgetsBindingObserver {
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
    WidgetsBinding.instance.addObserver(this);
    PwaUpdateService.instance.start();
    bindWebForeground(PwaUpdateService.instance.checkForUpdate);
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
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeShell(index: 0)),
        ),
        GoRoute(
          path: '/e/:z',
          pageBuilder: (context, state) {
            final z = int.tryParse(state.pathParameters['z'] ?? '') ?? 1;
            selection.select(z);
            return const NoTransitionPage(child: HomeShell(index: 1));
          },
        ),
        GoRoute(
          path: '/e/:z/spectra',
          pageBuilder: (context, state) {
            final z = int.tryParse(state.pathParameters['z'] ?? '') ?? 1;
            selection.select(z);
            return const NoTransitionPage(child: HomeShell(index: 3));
          },
        ),
        GoRoute(
          path: '/compare/:a/:b',
          pageBuilder: (context, state) {
            final a = int.tryParse(state.pathParameters['a'] ?? '') ?? 6;
            final b = int.tryParse(state.pathParameters['b'] ?? '') ?? 14;
            selection.setPair(a, b);
            return const NoTransitionPage(child: HomeShell(index: 2));
          },
        ),
      ],
    );
    _boot();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      PwaUpdateService.instance.checkForUpdate();
    }
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
        title: 'Element Deck',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppBrand.canvas,
          colorScheme: const ColorScheme.dark(
            surface: AppBrand.canvas,
            primary: AppBrand.action,
          ),
        ),
        home: const Stack(
          children: [
            AppSplash(caption: 'Opening the table…'),
            PwaUpdateBanner(),
          ],
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
            builder: (context, child) {
              return AmbientBackground(
                child: Stack(
                  children: [
                    child ?? const SizedBox.shrink(),
                    const PwaUpdateBanner(),
                  ],
                ),
              );
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
