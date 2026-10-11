import 'package:flutter/services.dart' show rootBundle;

/// Loads help markdown from bundled assets, with English as the only locale.
class HelpContentLoader {
  HelpContentLoader._();

  static final Map<String, String> _cache = {};

  static String assetPath(String topicId) => 'assets/help/en/$topicId.md';

  static Future<String> loadMarkdown({
    required String topicId,
    String unavailableMessage = 'Help is unavailable for this screen.',
  }) async {
    final cached = _cache[topicId];
    if (cached != null) return cached;

    try {
      final markdown = await rootBundle.loadString(assetPath(topicId));
      _cache[topicId] = markdown;
      return markdown;
    } catch (_) {
      _cache[topicId] = unavailableMessage;
      return unavailableMessage;
    }
  }

  static void clearCache() => _cache.clear();

  /// First markdown H1, used for the help app-bar title.
  static String? headingFromMarkdown(String? markdown) {
    if (markdown == null || markdown.isEmpty) return null;
    for (final line in markdown.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.startsWith('# ')) {
        final heading = trimmed.substring(2).trim();
        if (heading.isNotEmpty) return heading;
      }
    }
    return null;
  }
}
