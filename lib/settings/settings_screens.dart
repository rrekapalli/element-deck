import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../account/account_controller.dart';
import '../billing/pack_ids.dart';
import '../billing/purchase_service.dart';
import '../data/learner_database.dart';
import '../help/help_catalog.dart';
import '../help/help_screen.dart';
import '../packs/pack_service.dart';
import '../providers/catalog_controller.dart';
import '../providers/settings_controller.dart';
import '../providers/theme_controller.dart';
import '../theme/app_brand.dart';
import '../theme/app_theme.dart';
import '../widgets/depth_control.dart';

class SettingsHub extends StatelessWidget {
  const SettingsHub({super.key});

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountController>();
    final catalog = context.watch<CatalogController>();
    return ListView(
      children: [
        ListTile(
          title: Text(account.user?.displayName ?? 'On this device'),
          subtitle: Text(
            account.user?.email ??
                (catalog.isPreview
                    ? 'Preview catalog'
                    : 'On-device catalog · ${catalog.pack.elements.length} elements'),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.manage_accounts),
          title: const Text('Account settings'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AccountSettingsPage()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.tune),
          title: const Text('App Config'),
          subtitle: const Text('Learning mode, units, appearance'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AppSettingsPage()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.monitor_heart_outlined),
          title: const Text('App Health'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AppHealthPage()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Help'),
          onTap: () => openHelp(context, HelpCatalog.settings),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AboutPage()),
          ),
        ),
      ],
    );
  }
}

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    final settings = context.watch<SettingsController>();
    return Scaffold(
      appBar: helpAppBar(
        context,
        title: 'App Config',
        topicId: HelpCatalog.appSettings,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Learning mode'),
            subtitle: Text(
              'Beginner is Classes 8–10. Intermediate is Classes 11–12 and JEE. Advanced is undergraduate.',
            ),
          ),
          const DepthControl(),
          const Divider(),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Appearance'),
          ),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.light, label: Text('Light')),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
              ButtonSegment(value: ThemeMode.system, label: Text('System')),
            ],
            selected: {theme.mode},
            onSelectionChanged: (s) => theme.setMode(s.first),
          ),
          Wrap(
            children: [
              for (final id in ColorThemeId.values)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: ChoiceChip(
                    label: Text(id.label),
                    selected: theme.colorTheme == id,
                    onSelected: (_) => theme.setColorTheme(id),
                  ),
                ),
            ],
          ),
          SwitchListTile(
            title: const Text('Frosted glass'),
            value: theme.glass,
            onChanged: theme.setGlass,
          ),
          SwitchListTile(
            title: const Text('Reduce glow'),
            value: theme.reduceGlow,
            onChanged: theme.setReduceGlow,
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Persona'),
            trailing: DropdownButton<String>(
              value: settings.persona,
              items: const [
                DropdownMenuItem(value: 'student', child: Text('Student')),
                DropdownMenuItem(value: 'educator', child: Text('Educator')),
                DropdownMenuItem(
                  value: 'enthusiast',
                  child: Text('Enthusiast'),
                ),
              ],
              onChanged: (v) => settings.setPersona(v!),
            ),
          ),
          const Divider(),
          const ListTile(contentPadding: EdgeInsets.zero, title: Text('Units')),
          SwitchListTile(
            title: const Text('Temperature in °C'),
            value: settings.temperature == 'C',
            onChanged: (v) => settings.setTemperature(v ? 'C' : 'K'),
          ),
          SwitchListTile(
            title: const Text('Energy in kJ/mol'),
            value: settings.energy == 'kJ/mol',
            onChanged: (v) => settings.setEnergy(v ? 'kJ/mol' : 'eV'),
          ),
          SwitchListTile(
            title: const Text('Length in Å'),
            value: settings.length == 'angstrom',
            onChanged: (v) => settings.setLength(v ? 'angstrom' : 'pm'),
          ),
          SwitchListTile(
            title: const Text('Noble-gas shorthand'),
            value: settings.configShorthand,
            onChanged: settings.setShorthand,
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Sonification'),
            value: settings.sonification,
            onChanged: settings.setSonification,
          ),
          SwitchListTile(
            title: const Text('Reduced motion'),
            value: settings.reducedMotion,
            onChanged: settings.setReducedMotion,
          ),
        ],
      ),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountController>();
    final pack = context.read<PackService>();
    final billing = context.read<PurchaseService>();
    final db = context.read<LearnerDatabase>();
    return Scaffold(
      appBar: helpAppBar(
        context,
        title: 'Account settings',
        topicId: HelpCatalog.accountSettings,
      ),
      body: ListView(
        children: [
          if (account.user == null)
            ListTile(
              title: const Text('Not signed in'),
              subtitle: const Text(
                'Sign in to buy, restore, and download the pack.',
              ),
              trailing: FilledButton(
                onPressed: account.signInGoogle,
                child: const Text('Sign in with Google'),
              ),
            )
          else
            ListTile(
              title: Text(account.user!.displayName ?? 'Signed in'),
              subtitle: Text('${account.user!.email}\nSigned in with Google'),
            ),
          ListTile(
            title: const Text('Packages'),
            subtitle: Text(
              !coursePacksEnabled
                  ? 'Off while we test. Learning Mode chooses the depth; every element is open.'
                  : account.packages.isEmpty
                  ? 'Preview only · five elements at all three courses'
                  : account.packages.join(', '),
            ),
          ),
          if (coursePacksEnabled)
            for (final id in storeProductIds)
              ListTile(
                title: Text(packTitles[id] ?? id),
                subtitle: Text(
                  account.packages.contains(id) ||
                          account.packages.contains(packLegacy)
                      ? 'Owned'
                      : 'Buy · ${billing.priceLabel(id)}',
                ),
                onTap:
                    account.packages.contains(id) ||
                        account.packages.contains(packLegacy)
                    ? null
                    : () => billing.buy(id),
              ),
          ListTile(
            title: const Text('Restore purchases'),
            onTap: billing.restore,
          ),
          ListTile(
            title: const Text('Download content pack'),
            subtitle: Text(pack.status ?? account.packVersion ?? ''),
            onTap: () async {
              await pack.downloadIfEntitled();
              if (context.mounted) {
                await context.read<CatalogController>().reload(
                  hasCoreEntitlement: account.hasCore,
                );
              }
            },
          ),
          ListTile(
            title: const Text('Export my learner data'),
            onTap: () async {
              final json = await db.exportJson();
              await SharePlus.instance.share(
                ShareParams(text: jsonEncode(json)),
              );
            },
          ),
          if (account.user != null)
            ListTile(title: const Text('Sign out'), onTap: account.signOut),
          ListTile(
            title: const Text('Erase this device'),
            onTap: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) {
                  final c = TextEditingController();
                  return AlertDialog(
                    title: const Text('Erase this device'),
                    content: TextField(
                      controller: c,
                      decoration: const InputDecoration(
                        hintText: 'Type DELETE',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () =>
                            Navigator.pop(context, c.text == 'DELETE'),
                        child: const Text('Erase'),
                      ),
                    ],
                  );
                },
              );
              if (ok == true) await account.eraseDevice();
            },
          ),
          if (account.lastError != null)
            ListTile(title: Text(account.lastError!)),
          if (billing.message != null) ListTile(title: Text(billing.message!)),
        ],
      ),
    );
  }
}

class AppHealthPage extends StatelessWidget {
  const AppHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    final account = context.watch<AccountController>();
    return Scaffold(
      appBar: helpAppBar(
        context,
        title: 'App Health',
        topicId: HelpCatalog.appHealth,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('On-device catalog'),
            subtitle: Text(
              '${catalog.pack.elements.length} elements · ${catalog.pack.version}',
            ),
          ),
          ListTile(
            title: const Text('Content pack cache'),
            subtitle: Text(
              catalog.isPreview
                  ? 'using bundled file'
                  : 'loaded ${catalog.pack.version}',
            ),
          ),
          ListTile(
            title: const Text('Firebase'),
            subtitle: Text(
              account.firebaseReady
                  ? 'configured'
                  : 'not configured · preview still works',
            ),
          ),
          ListTile(
            title: const Text('Purchases'),
            subtitle: Text(account.packages.join(', ').ifEmpty('none')),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: helpAppBar(context, title: 'About', topicId: HelpCatalog.about),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          Center(child: AppMark(size: 96)),
          SizedBox(height: 16),
          Text(
            'Element Deck',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6),
          _AppVersionLine(),
          SizedBox(height: 16),
          Text(
            'Element Deck explains published elemental data for learning. '
            'It is not a lab measurement, a specification for engineering or medicine, '
            'or a substitute for the cited dataset.',
          ),
        ],
      ),
    );
  }
}

class _AppVersionLine extends StatefulWidget {
  const _AppVersionLine();

  @override
  State<_AppVersionLine> createState() => _AppVersionLineState();
}

class _AppVersionLineState extends State<_AppVersionLine> {
  late final Future<PackageInfo> _info = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.55);
    final style = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(color: muted);
    return FutureBuilder<PackageInfo>(
      future: _info,
      builder: (context, snapshot) {
        final version = snapshot.data?.version.trim() ?? '';
        return Text(
          version.isEmpty ? '' : 'Version $version',
          textAlign: TextAlign.center,
          style: style,
        );
      },
    );
  }
}

extension on String {
  String ifEmpty(String other) => isEmpty ? other : this;
}
