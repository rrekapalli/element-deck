/// Parsed in-app help topic: body copy vs hero screenshots.
class HelpDocument {
  final String? title;
  final List<HelpHeroImage> images;
  final String? imageCaption;
  final String bodyMarkdown;

  const HelpDocument({
    this.title,
    required this.images,
    this.imageCaption,
    required this.bodyMarkdown,
  });

  bool get hasHeroImages => images.isNotEmpty;

  /// Splits a leading H1, consecutive `![...](asset:...)` shots, and an
  /// optional `Callouts:` line from the remaining markdown body.
  static HelpDocument parse(String markdown) {
    final lines = markdown.split('\n');
    var i = 0;

    bool blank(int idx) => idx < lines.length && lines[idx].trim().isEmpty;

    void skipBlanks() {
      while (blank(i)) {
        i++;
      }
    }

    skipBlanks();
    String? title;
    if (i < lines.length && lines[i].trim().startsWith('# ')) {
      title = lines[i].trim().substring(2).trim();
      if (title.isEmpty) title = null;
      i++;
      skipBlanks();
    }

    final images = <HelpHeroImage>[];
    while (i < lines.length) {
      final img = HelpHeroImage.tryParse(lines[i]);
      if (img == null) break;
      images.add(img);
      i++;
      skipBlanks();
    }

    String? caption;
    if (i < lines.length) {
      final trimmed = lines[i].trim();
      const prefix = 'Callouts:';
      if (trimmed.toLowerCase().startsWith(prefix.toLowerCase())) {
        caption = trimmed.substring(prefix.length).trim();
        if (caption.isEmpty) caption = null;
        i++;
        skipBlanks();
      }
    }

    final body = lines.skip(i).join('\n').trim();
    return HelpDocument(
      title: title,
      images: images,
      imageCaption: caption,
      bodyMarkdown: body,
    );
  }
}

class HelpHeroImage {
  final String assetPath;
  final String alt;

  const HelpHeroImage({required this.assetPath, required this.alt});

  static final _pattern = RegExp(
    r'^!\[([^\]]*)\]\((asset:)?(assets/help/images/[^)]+)\)\s*$',
  );

  static HelpHeroImage? tryParse(String line) {
    final match = _pattern.firstMatch(line.trim());
    if (match == null) return null;
    return HelpHeroImage(alt: match.group(1) ?? '', assetPath: match.group(3)!);
  }
}
