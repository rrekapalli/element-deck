import 'package:flutter/material.dart';

/// Family colors are data. Theme never repaints them.
class ElementSpectrum {
  const ElementSpectrum._();

  static const nonmetal = Color(0xFF38BDF8);
  static const noble = Color(0xFFA855F7);
  static const alkali = Color(0xFFF59E0B);
  static const transition = Color(0xFF10B981);
  static const postTransition = Color(0xFFEC4899);
  static const metalloid = Color(0xFF6366F1);
  static const fBlock = Color(0xFFF43F5E);

  static Color of(String categoryId) {
    return switch (categoryId) {
      'noble-gas' => noble,
      'alkali-metal' || 'alkaline-earth' => alkali,
      'transition-metal' => transition,
      'post-transition' => postTransition,
      'metalloid' => metalloid,
      'lanthanide' || 'actinide' => fBlock,
      _ => nonmetal,
    };
  }
}
