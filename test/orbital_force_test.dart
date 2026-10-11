import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:element_deck/models/catalog.dart';
import 'package:element_deck/models/orbital_force.dart';
import 'package:element_deck/widgets/electron_force_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('hydrogen binding energy is the Rydberg energy', () {
    final cloud = ElectronCloud.fromConfiguration(z: 1, configuration: '1s1');
    expect(cloud, isNotNull);
    expect(cloud!.electrons, hasLength(1));
    expect(cloud.bindingOf('1s'), closeTo(13.6, 0.001));
  });

  test('neon subshells are ordered by binding energy', () {
    final cloud = ElectronCloud.fromConfiguration(
      z: 10,
      configuration: '[He] 2s2 2p6',
    )!;
    expect(cloud.electrons, hasLength(10));
    expect(cloud.bindingOf('1s'), greaterThan(cloud.bindingOf('2s')));
    expect(cloud.bindingOf('2s'), greaterThan(cloud.bindingOf('2p')));
    final paired = cloud.electrons.where((e) => e.partner != null).length;
    expect(paired, 10);
  });

  test('helium is bound more tightly than hydrogen', () {
    final hydrogen = ElectronCloud.fromConfiguration(
      z: 1,
      configuration: '1s1',
    )!;
    final helium = ElectronCloud.fromConfiguration(z: 2, configuration: '1s2')!;
    expect(helium.bindingOf('1s'), greaterThan(hydrogen.bindingOf('1s')));
  });

  test('titanium 4s sits outside 3d because it is less tightly bound', () {
    final cloud = ElectronCloud.fromConfiguration(
      z: 22,
      configuration: '[Ar] 3d2 4s2',
    )!;
    expect(cloud.bindingOf('3d'), greaterThan(cloud.bindingOf('4s')));
    final sim = ElectronSim(cloud)
      ..prepare()
      ..layout(360, 360);
    final d = cloud.electrons.firstWhere((e) => e.label == '3d');
    final s = cloud.electrons.firstWhere((e) => e.label == '4s');
    expect(sim.targetRadius(s), greaterThan(sim.targetRadius(d)));
  });

  test('exceptions keep the catalog electron count', () {
    expect(
      ElectronCloud.fromConfiguration(
        z: 24,
        configuration: '[Ar] 3d5 4s1',
      )!.electrons,
      hasLength(24),
    );
    expect(
      ElectronCloud.fromConfiguration(
        z: 46,
        configuration: '[Kr] 4d10',
      )!.electrons,
      hasLength(46),
    );
    expect(
      ElectronCloud.fromConfiguration(
        z: 118,
        configuration: '[Rn] 5f14 6d10 7s2 7p6',
      )!.electrons,
      hasLength(118),
    );
  });

  test(
    'every catalog configuration expands to Z electrons and the stored shells',
    () {
      final file = File('assets/catalog/core.json');
      final pack = CatalogPack.fromJson(
        jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
      );
      expect(pack.elements, hasLength(118));
      for (final element in pack.elements) {
        final cloud = ElectronCloud.fromConfiguration(
          z: element.z,
          configuration: element.electronConfigFull,
        );
        expect(cloud, isNotNull, reason: element.symbol);
        expect(cloud!.electrons, hasLength(element.z), reason: element.symbol);
        final byN = <int, int>{};
        for (final electron in cloud.electrons) {
          byN[electron.n] = (byN[electron.n] ?? 0) + 1;
        }
        final maxN = byN.keys.reduce(math.max);
        final counts = [for (var n = 1; n <= maxN; n++) byN[n] ?? 0];
        expect(
          counts,
          element.shellCounts,
          reason: '${element.symbol} ${element.electronConfigFull}',
        );
      }
    },
  );

  test('a more tightly bound electron is pulled harder toward its orbit', () {
    final cloud = ElectronCloud.fromConfiguration(
      z: 10,
      configuration: '[He] 2s2 2p6',
    )!;
    final sim = ElectronSim(cloud)
      ..prepare()
      ..layout(360, 360)
      ..repulsion = false
      ..linkForces = false;
    final inner = cloud.electrons.firstWhere((e) => e.label == '1s');
    final outer = cloud.electrons.firstWhere((e) => e.label == '2p');
    final innerTarget = sim.targetRadius(inner);
    final outerTarget = sim.targetRadius(outer);
    inner
      ..x = innerTarget + 30
      ..y = 0
      ..vx = 0
      ..vy = 0;
    outer
      ..x = outerTarget + 30
      ..y = 0
      ..vx = 0
      ..vy = 0;
    sim.step(alpha: 1, cruise: false);
    final innerMoved = (innerTarget + 30) - inner.x;
    final outerMoved = (outerTarget + 30) - outer.x;
    expect(innerMoved, greaterThan(outerMoved));
  });

  test('neon electrons settle onto energy-ordered orbits', () {
    final cloud = ElectronCloud.fromConfiguration(
      z: 10,
      configuration: '[He] 2s2 2p6',
    )!;
    final sim = ElectronSim(cloud)
      ..prepare()
      ..layout(360, 360)
      ..seed(jitter: false)
      ..settle();
    double meanRadius(String label) {
      final group = cloud.electrons.where((e) => e.label == label);
      final sum = group.fold<double>(
        0,
        (total, e) => total + math.sqrt(e.x * e.x + e.y * e.y),
      );
      return sum / group.length;
    }

    final r1 = meanRadius('1s');
    final r2 = meanRadius('2s');
    final r3 = meanRadius('2p');
    expect(r1, lessThan(r2), reason: 'radii 1s=$r1 2s=$r2 2p=$r3');
    expect(r2, lessThan(r3), reason: 'radii 1s=$r1 2s=$r2 2p=$r3');
    for (final electron in cloud.electrons) {
      final radius = math.sqrt(
        electron.x * electron.x + electron.y * electron.y,
      );
      final target = sim.targetRadius(electron);
      expect(
        radius,
        closeTo(target, target * 0.22 + 8),
        reason: '${electron.label} r=$radius target=$target',
      );
      expect(radius.isNaN, isFalse);
    }
  });

  test('nitrogen leaves three unpaired 2p electrons', () {
    final cloud = ElectronCloud.fromConfiguration(
      z: 7,
      configuration: '[He] 2s2 2p3',
    )!;
    final p = cloud.electrons.where((e) => e.label == '2p');
    expect(p, hasLength(3));
    expect(p.where((e) => e.partner != null), isEmpty);
  });

  testWidgets('neon diagram paints orbit rings and survives a few frames', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ElectronForceGraph(
              atomicNumber: 10,
              symbol: 'Ne',
              configuration: '[He] 2s2 2p6',
              accent: Color(0xFFA855F7),
              reducedMotion: true,
              energyUnit: 'eV',
            ),
          ),
        ),
      ),
    );
    expect(find.text('Ne'), findsOneWidget);
    expect(find.textContaining('subshell'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ElectronForceGraph(
            atomicNumber: 10,
            symbol: 'Ne',
            configuration: '[He] 2s2 2p6',
            accent: Color(0xFFA855F7),
            reducedMotion: false,
            energyUnit: 'eV',
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 32));
    expect(find.textContaining('1s'), findsWidgets);
    expect(find.textContaining('sqrt'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
