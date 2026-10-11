import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

class Sonify {
  Sonify();

  final _player = AudioPlayer();

  Future<void> playHz(double hz, {Duration length = const Duration(milliseconds: 900)}) async {
    final freq = hz.clamp(80.0, 1400.0);
    final wav = _sineWav(freq, length);
    await _player.stop();
    await _player.play(BytesSource(wav, mimeType: 'audio/wav'));
  }

  Future<void> stop() => _player.stop();

  Uint8List _sineWav(double freq, Duration length) {
    const sampleRate = 22050;
    final n = (sampleRate * length.inMilliseconds / 1000).round();
    final bytes = BytesBuilder();
    const dataSize = 0; // filled later
    void u32(int v) {
      bytes.add([v & 255, (v >> 8) & 255, (v >> 16) & 255, (v >> 24) & 255]);
    }

    void u16(int v) {
      bytes.add([v & 255, (v >> 8) & 255]);
    }

    bytes.add('RIFF'.codeUnits);
    u32(36 + n * 2);
    bytes.add('WAVE'.codeUnits);
    bytes.add('fmt '.codeUnits);
    u32(16);
    u16(1);
    u16(1);
    u32(sampleRate);
    u32(sampleRate * 2);
    u16(2);
    u16(16);
    bytes.add('data'.codeUnits);
    u32(n * 2);
    for (var i = 0; i < n; i++) {
      final env = min(1.0, i / 800) * min(1.0, (n - i) / 1200);
      final sample = (sin(2 * pi * freq * i / sampleRate) * env * 28000).round();
      u16(sample & 0xFFFF);
    }
    assert(dataSize >= 0);
    return bytes.toBytes();
  }
}
