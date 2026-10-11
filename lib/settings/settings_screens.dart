import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../account/account_controller.dart';
import '../billing/purchase_service.dart';
import '../classroom/classroom_controller.dart';
import '../data/learner_database.dart';
import '../packs/pack_service.dart';
import '../providers/catalog_controller.dart';
import '../providers/settings_controller.dart';
import '../providers/theme_controller.dart';
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
          leading: const Icon(Icons.school_outlined),
          title: const Text('Classroom'),
          subtitle: const Text('After Element Deck restores on another device'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ClassroomPage()),
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HelpPage()),
          ),
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
      appBar: AppBar(title: const Text('App Config')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Learning mode'),
            subtitle: Text(
              'Beginner, Intermediate, and Advanced change how Spectra explains a line.',
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
      appBar: AppBar(title: const Text('Account settings')),
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
              account.packages.isEmpty
                  ? 'Preview only'
                  : account.packages.join(', '),
            ),
          ),
          ListTile(
            title: const Text('Buy Element Deck'),
            onTap: () => billing.buy('element-deck'),
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
      appBar: AppBar(title: const Text('App Health')),
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

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Table', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            'Periodic table, search, and family chips. Learning mode is in App Config.',
          ),
          SizedBox(height: 12),
          Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Dossier, curriculum, simulate reaction when curated.'),
          SizedBox(height: 12),
          Text('Compare', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Pairs, computed deltas, PDF dossier.'),
          SizedBox(height: 12),
          Text('Spectra', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            'Lines, sonification (divided by 10^12), isotopes. No match percentages.',
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
      appBar: AppBar(title: const Text('About')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Element Deck 0.1.0\n\n'
          'Element Deck explains published elemental data for learning. '
          'It is not a lab measurement, a specification for engineering or medicine, '
          'or a substitute for the cited dataset.',
        ),
      ),
    );
  }
}

class ClassroomPage extends StatefulWidget {
  const ClassroomPage({super.key});

  @override
  State<ClassroomPage> createState() => _ClassroomPageState();
}

class _ClassroomPageState extends State<ClassroomPage> {
  final name = TextEditingController(text: 'Week 1');
  final code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final room = context.watch<ClassroomController>();
    final account = context.watch<AccountController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Classroom')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            account.hasClassroom
                ? 'Classroom package is active on this account.'
                : 'Buy Classroom after Element Deck. Join codes for minors wait on terms. Each learner still needs Element Deck.',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Class name'),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => room.create(
              name: name.text,
              pinned: const [1, 6, 10, 14, 22],
              depth: 'intermediate',
            ),
            child: const Text('Create class'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: code,
            decoration: const InputDecoration(labelText: 'Join code'),
          ),
          TextButton(
            onPressed: () => room.join(code.text),
            child: const Text('Join'),
          ),
          if (room.current != null) ...[
            ListTile(
              title: Text(room.current!.name),
              subtitle: Text(
                'Code ${room.current!.joinCode} · depth ${room.current!.suggestedDepth}',
              ),
            ),
            Text('Pinned Z: ${room.current!.pinned.join(", ")}'),
            TextButton(
              onPressed: room.leave,
              child: const Text('Show all elements'),
            ),
          ],
          if (room.error != null) Text(room.error!),
        ],
      ),
    );
  }
}

extension on String {
  String ifEmpty(String other) => isEmpty ? other : this;
}
