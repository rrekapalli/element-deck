/// Stable help topic IDs and the Previous/Next order of the user guide.
class HelpTopic {
  final String id;
  final String title;

  const HelpTopic({required this.id, required this.title});
}

/// Catalog of in-app help topics. [guideOrder] is the Previous/Next sequence.
class HelpCatalog {
  HelpCatalog._();

  static const table = 'table';
  static const details = 'details';
  static const compare = 'compare';
  static const spectra = 'spectra';
  static const settings = 'settings';
  static const accountSettings = 'account_settings';
  static const appSettings = 'app_settings';
  static const classroom = 'classroom';
  static const appHealth = 'app_health';
  static const about = 'about';

  static const List<HelpTopic> guideOrder = [
    HelpTopic(id: table, title: 'Table'),
    HelpTopic(id: details, title: 'Details'),
    HelpTopic(id: compare, title: 'Compare'),
    HelpTopic(id: spectra, title: 'Spectra'),
    HelpTopic(id: settings, title: 'Settings'),
    HelpTopic(id: accountSettings, title: 'Account settings'),
    HelpTopic(id: appSettings, title: 'App Config'),
    HelpTopic(id: classroom, title: 'Classroom'),
    HelpTopic(id: appHealth, title: 'App Health'),
    HelpTopic(id: about, title: 'About'),
  ];

  static const roomTopics = [table, details, compare, spectra];

  static final Map<String, HelpTopic> _byId = {
    for (final topic in guideOrder) topic.id: topic,
  };

  static HelpTopic? topicById(String id) => _byId[id];

  static int indexOf(String id) => guideOrder.indexWhere((t) => t.id == id);

  static HelpTopic? previous(String id) {
    final i = indexOf(id);
    if (i <= 0) return null;
    return guideOrder[i - 1];
  }

  static HelpTopic? next(String id) {
    final i = indexOf(id);
    if (i < 0 || i >= guideOrder.length - 1) return null;
    return guideOrder[i + 1];
  }
}
