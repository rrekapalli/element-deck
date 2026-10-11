import 'dart:math' as math;

/// Electrons, subshells, and the force simulation behind the configuration diagram.
///
/// Binding energies are Slater estimates: E = 13.6 eV · (Z_eff / n*)².
/// Each (n, l) is its own group, so s and p do not share one energy.
/// Screening for an electron in (n, l):
/// - another electron in the same subshell: 0.35 (0.30 in 1s)
/// - same n, smaller l: 0.85
/// - n − 1, when this electron is s or p: 0.85; otherwise 1.00
/// - n − 2 and lower: 1.00
/// - higher n, or the same n with larger l: 0
/// n* is Slater's 1, 2, 3, 3.7, 4.0, 4.2, and 4.4 for n = 7.
///
/// Gravity in the simulation is that energy. The orbital radius follows
/// 1/√E (a Bohr-like mapping, fit to the canvas). The spring that holds an
/// electron on its ring is stiffer when E is larger, so a core electron
/// snaps back harder than a valence electron. Paired electrons in one
/// orbital are a linked component; orbitals are not linked to each other.
class OrbitalElectron {
  OrbitalElectron({
    required this.n,
    required this.l,
    required this.label,
    required this.bindingEv,
    required this.angle,
    this.partner,
  }) : orbitBinding = bindingEv;

  final int n;
  final int l;
  final String label;
  final double bindingEv;
  final int? partner;

  /// Home angle on the ring, radians.
  final double angle;

  /// Energy that sets this electron's orbital radius. Same as [bindingEv].
  double orbitBinding;

  double x = 0;
  double y = 0;
  double vx = 0;
  double vy = 0;
  bool pinned = false;
  double pinX = 0;
  double pinY = 0;
}

class OrbitRing {
  const OrbitRing({
    required this.label,
    required this.bindingEv,
    required this.radius,
    required this.n,
  });

  final String label;
  final double bindingEv;
  final double radius;
  final int n;
}

/// An empty electron seat on a subshell that is not full.
///
/// Drawn on the ring; it is not part of the force simulation.
class OrbitalVacancy {
  const OrbitalVacancy({required this.label, required this.angle});

  final String label;

  /// Home angle on the ring, radians. Matches where that electron would sit.
  final double angle;
}

class ElectronCloud {
  ElectronCloud({
    required this.z,
    required this.electrons,
    this.vacancies = const [],
  });

  final int z;
  final List<OrbitalElectron> electrons;

  /// Missing electrons in subshells that have started filling and are not full.
  final List<OrbitalVacancy> vacancies;

  static const nobleGasCores = <String, String>{
    'He': '1s2',
    'Ne': '1s2 2s2 2p6',
    'Ar': '1s2 2s2 2p6 3s2 3p6',
    'Kr': '1s2 2s2 2p6 3s2 3p6 4s2 3d10 4p6',
    'Xe': '1s2 2s2 2p6 3s2 3p6 4s2 3d10 4p6 5s2 4d10 5p6',
    'Rn': '1s2 2s2 2p6 3s2 3p6 4s2 3d10 4p6 5s2 4d10 5p6 6s2 4f14 5d10 6p6',
  };

  static const _nStar = <double>[0, 1, 2, 3, 3.7, 4.0, 4.2, 4.4];
  static const _lOf = <String, int>{'s': 0, 'p': 1, 'd': 2, 'f': 3};

  /// Every subshell, with a noble-gas core such as `[He]` written out.
  ///
  /// `[He] 2s2 2p1` becomes `1s2 2s2 2p1`. Order follows the shorthand:
  /// the core, then the valence terms as written.
  static String expandedConfiguration(String configuration) {
    final subs = _expand(configuration);
    if (subs.isEmpty) return configuration.trim();
    return subs.map((s) => '${s.label}${s.count}').join(' ');
  }

  /// Parses a full or noble-gas configuration into one node per electron.
  /// Returns null when the string yields no electrons.
  static ElectronCloud? fromConfiguration({
    required int z,
    required String configuration,
  }) {
    final subs = _expand(configuration);
    if (subs.isEmpty) return null;

    final bindings = <double>[for (final s in subs) _slaterBinding(z, s, subs)];

    final electrons = <OrbitalElectron>[];
    final vacancies = <OrbitalVacancy>[];
    for (var i = 0; i < subs.length; i++) {
      final s = subs[i];
      final orbitals = 2 * s.l + 1;
      final singles = math.min(s.count, orbitals);
      final paired = math.max(0, s.count - singles);
      final phase = i * 2.399963;
      for (var o = 0; o < singles; o++) {
        final base = phase + 2 * math.pi * o / orbitals;
        final pair = o < paired;
        final first = electrons.length;
        electrons.add(
          OrbitalElectron(
            n: s.n,
            l: s.l,
            label: s.label,
            bindingEv: bindings[i],
            angle: base - (pair ? 0.28 : 0),
            partner: pair ? first + 1 : null,
          ),
        );
        if (pair) {
          electrons.add(
            OrbitalElectron(
              n: s.n,
              l: s.l,
              label: s.label,
              bindingEv: bindings[i],
              angle: base + 0.28,
              partner: first,
            ),
          );
        } else {
          // Hund leaves this orbital half full. The second seat stays empty.
          vacancies.add(OrbitalVacancy(label: s.label, angle: base + 0.28));
        }
      }
      for (var o = singles; o < orbitals; o++) {
        final base = phase + 2 * math.pi * o / orbitals;
        vacancies.add(OrbitalVacancy(label: s.label, angle: base - 0.28));
        vacancies.add(OrbitalVacancy(label: s.label, angle: base + 0.28));
      }
    }

    if (electrons.isEmpty) return null;
    return ElectronCloud(z: z, electrons: electrons, vacancies: vacancies);
  }

  double bindingOf(String label) {
    return electrons.firstWhere((e) => e.label == label).bindingEv;
  }

  static List<_Subshell> _expand(String configuration) {
    var text = configuration.trim();
    if (text.isEmpty) return const [];
    text = text.replaceAllMapped(RegExp(r'\[([A-Z][a-z]?)\]'), (m) {
      return nobleGasCores[m.group(1)] ?? '';
    });
    final matches = RegExp(r'(\d)([spdf])(\d+)').allMatches(text);
    final subs = <_Subshell>[];
    for (final m in matches) {
      final n = int.parse(m.group(1)!);
      final letter = m.group(2)!;
      final count = int.parse(m.group(3)!);
      if (n < 1 || n > 7 || count <= 0) continue;
      final l = _lOf[letter]!;
      final existing = subs.indexWhere((s) => s.n == n && s.l == l);
      if (existing >= 0) {
        final prior = subs[existing];
        subs[existing] = _Subshell(n, l, prior.count + count, prior.label);
      } else {
        subs.add(_Subshell(n, l, count, '$n$letter'));
      }
    }
    return subs;
  }

  static double _slaterBinding(int z, _Subshell self, List<_Subshell> all) {
    var shielding = 0.0;
    for (final other in all) {
      final same = other.n == self.n && other.l == self.l;
      if (same) {
        final others = other.count - 1;
        if (others > 0) {
          shielding += others * (self.n == 1 ? 0.30 : 0.35);
        }
        continue;
      }
      if (other.n > self.n) continue;
      if (other.n == self.n && other.l > self.l) continue;
      if (other.n == self.n && other.l < self.l) {
        shielding += other.count * 0.85;
        continue;
      }
      final innerShell = other.n <= self.n - 2;
      final sOrP = self.l <= 1;
      if (!innerShell && sOrP) {
        shielding += other.count * 0.85;
      } else {
        shielding += other.count * 1.0;
      }
    }
    final zEff = math.max(0.3, z - shielding);
    final nStar = _nStar[self.n];
    final ratio = zEff / nStar;
    return 13.6 * ratio * ratio;
  }
}

class _Subshell {
  const _Subshell(this.n, this.l, this.count, this.label);
  final int n;
  final int l;
  final int count;
  final String label;
}

/// Force-directed layout. Positions are in pixels relative to the nucleus.
class ElectronSim {
  ElectronSim(this.cloud);

  final ElectronCloud cloud;

  bool linkForces = true;
  bool repulsion = true;

  double width = 0;
  double height = 0;
  int? dragIndex;

  double _minB = 1;
  double _maxB = 1;
  List<double> _ax = const [];
  List<double> _ay = const [];

  List<OrbitalElectron> get electrons => cloud.electrons;

  double get nodeRadius {
    final n = electrons.length;
    if (n <= 12) return 6;
    if (n <= 30) return 4.5;
    if (n <= 60) return 3.4;
    return 2.6;
  }

  void layout(double nextWidth, double nextHeight) {
    if (nextWidth <= 0 || nextHeight <= 0) return;
    if (width == 0 || height == 0) {
      width = nextWidth;
      height = nextHeight;
      return;
    }
    if (nextWidth == width && nextHeight == height) return;
    final prev = _outerRadius(width, height);
    final next = _outerRadius(nextWidth, nextHeight);
    final scale = prev == 0 ? 1.0 : next / prev;
    for (final e in electrons) {
      e.x *= scale;
      e.y *= scale;
    }
    width = nextWidth;
    height = nextHeight;
  }

  void prepare() {
    for (final e in electrons) {
      e.orbitBinding = e.bindingEv;
    }
    _minB = electrons.fold<double>(
      double.infinity,
      (m, e) => math.min(m, e.orbitBinding),
    );
    _maxB = electrons.fold<double>(0, (m, e) => math.max(m, e.orbitBinding));
    if (_minB == double.infinity || _minB <= 0) _minB = 1;
  }

  void seed({required bool jitter}) {
    final rng = math.Random(cloud.z * 997);
    for (final e in electrons) {
      final target = targetRadius(e);
      final radial = jitter
          ? target * (0.58 + rng.nextDouble() * 0.55)
          : target;
      final angle = e.angle + (jitter ? (rng.nextDouble() - 0.5) * 0.7 : 0);
      e.x = math.cos(angle) * radial;
      e.y = math.sin(angle) * radial;
      e.vx = jitter ? -math.sin(angle) * 0.7 : 0;
      e.vy = jitter ? math.cos(angle) * 0.7 : 0;
      e.pinned = false;
    }
  }

  /// Runs the layout to rest. Used for reduced motion and tests.
  void settle({int steps = 320}) {
    for (var i = 0; i < steps; i++) {
      final alpha = math.max(0.12, math.pow(0.985, i).toDouble());
      step(alpha: alpha, cruise: false);
    }
    for (final e in electrons) {
      e.vx = 0;
      e.vy = 0;
    }
  }

  double targetRadius(OrbitalElectron e) {
    final inner = 36.0;
    final outer = _outerRadius(width, height);
    if (outer <= inner) return inner;
    if (_maxB <= _minB * 1.02) {
      return inner + (outer - inner) * 0.62;
    }
    final raw = 1 / math.sqrt(e.orbitBinding);
    final rawMin = 1 / math.sqrt(_maxB);
    final rawMax = 1 / math.sqrt(_minB);
    final t = ((raw - rawMin) / (rawMax - rawMin)).clamp(0.0, 1.0);
    return inner + (outer - inner) * t;
  }

  int occupancy(String label) =>
      electrons.where((e) => e.label == label).length;

  List<OrbitRing> get rings {
    final map = <String, OrbitRing>{};
    for (final e in electrons) {
      map.putIfAbsent(
        e.label,
        () => OrbitRing(
          label: e.label,
          bindingEv: e.orbitBinding,
          radius: targetRadius(e),
          n: e.n,
        ),
      );
    }
    final list = map.values.toList()
      ..sort((a, b) => a.radius.compareTo(b.radius));
    return list;
  }

  int hit(double x, double y, {double slop = 22}) {
    var best = -1;
    var bestD = slop * slop;
    for (var i = 0; i < electrons.length; i++) {
      final e = electrons[i];
      final dx = e.x - x;
      final dy = e.y - y;
      final d2 = dx * dx + dy * dy;
      if (d2 <= bestD) {
        bestD = d2;
        best = i;
      }
    }
    return best;
  }

  void grab(int index, double x, double y) {
    dragIndex = index;
    final e = electrons[index];
    e.pinned = true;
    e.pinX = x;
    e.pinY = y;
    e.x = x;
    e.y = y;
    e.vx = 0;
    e.vy = 0;
  }

  void dragTo(double x, double y) {
    final index = dragIndex;
    if (index == null) return;
    final e = electrons[index];
    e.pinX = x;
    e.pinY = y;
    e.x = x;
    e.y = y;
  }

  void release() {
    final index = dragIndex;
    dragIndex = null;
    if (index == null) return;
    final e = electrons[index];
    e.pinned = false;
    e.vx = 0;
    e.vy = 0;
  }

  void step({required double alpha, required bool cruise}) {
    final n = electrons.length;
    if (_ax.length != n) {
      _ax = List<double>.filled(n, 0);
      _ay = List<double>.filled(n, 0);
    } else {
      for (var i = 0; i < n; i++) {
        _ax[i] = 0;
        _ay[i] = 0;
      }
    }

    if (repulsion && n > 1) {
      const cutoff = 96.0;
      const charge = 110.0;
      final floor = math.max(16.0, nodeRadius * nodeRadius * 2.2);
      for (var i = 0; i < n; i++) {
        final a = electrons[i];
        for (var j = i + 1; j < n; j++) {
          final b = electrons[j];
          var dx = b.x - a.x;
          var dy = b.y - a.y;
          var d2 = dx * dx + dy * dy;
          if (d2 > cutoff * cutoff) continue;
          if (d2 < floor) d2 = floor;
          final d = math.sqrt(d2);
          final f = charge * alpha / d2;
          final fx = f * dx / d;
          final fy = f * dy / d;
          _ax[i] -= fx;
          _ay[i] -= fy;
          _ax[j] += fx;
          _ay[j] += fy;
        }
      }
    }

    if (linkForces) {
      final rest = nodeRadius * 2.5;
      const linkK = 0.085;
      for (var i = 0; i < n; i++) {
        final partner = electrons[i].partner;
        if (partner == null || partner < i) continue;
        final a = electrons[i];
        final b = electrons[partner];
        final dx = b.x - a.x;
        final dy = b.y - a.y;
        final d = math.max(0.1, math.sqrt(dx * dx + dy * dy));
        final f = (d - rest) * linkK * alpha;
        final fx = f * dx / d;
        final fy = f * dy / d;
        _ax[i] += fx;
        _ay[i] += fy;
        _ax[partner] -= fx;
        _ay[partner] -= fy;
      }
    }

    for (var i = 0; i < n; i++) {
      final e = electrons[i];
      final r = math.sqrt(e.x * e.x + e.y * e.y);
      final ux = r < 0.8 ? 1.0 : e.x / r;
      final uy = r < 0.8 ? 0.0 : e.y / r;
      final target = targetRadius(e);
      // Spring constant is the binding energy in eV. Core electrons are stiff.
      final k = (e.bindingEv * 0.0016).clamp(0.045, 1.8);
      final pull = (-k * alpha * (r - target)).clamp(-7.0, 7.0);
      _ax[i] += ux * pull;
      _ay[i] += uy * pull;

      const core = 28.0;
      if (r < core && r > 0.8) {
        final push = (core - r) * 0.65;
        _ax[i] += ux * push;
        _ay[i] += uy * push;
      }

      if (cruise && !e.pinned) {
        final drift = 0.01 * math.sqrt(e.bindingEv.clamp(6.0, 120.0));
        _ax[i] += -uy * drift;
        _ay[i] += ux * drift;
      }
    }

    final damp = cruise ? 0.88 : 0.55;
    for (var i = 0; i < n; i++) {
      final e = electrons[i];
      if (e.pinned) {
        e.x = e.pinX;
        e.y = e.pinY;
        e.vx = 0;
        e.vy = 0;
        continue;
      }
      e.vx = (e.vx + _ax[i]) * damp;
      e.vy = (e.vy + _ay[i]) * damp;
      final speed = math.sqrt(e.vx * e.vx + e.vy * e.vy);
      if (speed > 12) {
        e.vx *= 12 / speed;
        e.vy *= 12 / speed;
      }
      e.x += e.vx;
      e.y += e.vy;
      if (e.x.isNaN || e.y.isNaN) {
        final target = targetRadius(e);
        e.x = math.cos(e.angle) * target;
        e.y = math.sin(e.angle) * target;
        e.vx = 0;
        e.vy = 0;
      }
    }
  }

  static double _outerRadius(double width, double height) {
    if (width <= 0 || height <= 0) return 36;
    return math.max(60.0, math.min(width, height) / 2 - 36);
  }
}
