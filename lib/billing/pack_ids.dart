/// Flip to true to gate dossiers, quizzes, and depths behind IAP.
const coursePacksEnabled = false;

const packBeginner = 'pack-beginner';
const packIntermediate = 'pack-intermediate';
const packAdvanced = 'pack-advanced';
const packLegacy = 'element-deck';

const storeProductIds = {
  packBeginner,
  packIntermediate,
  packAdvanced,
};

const packDepths = {
  packBeginner: 'beginner',
  packIntermediate: 'intermediate',
  packAdvanced: 'advanced',
};

const depthOrder = ['beginner', 'intermediate', 'advanced'];

const packTitles = {
  packBeginner: 'Beginner (Classes 8–10)',
  packIntermediate: 'Intermediate (Classes 11–12 and JEE)',
  packAdvanced: 'Advanced (Undergraduate)',
};

const packCaptions = {
  'beginner': 'Mode: Beginner · Classes 8–10.',
  'intermediate': 'Mode: Intermediate · Classes 11–12 and JEE.',
  'advanced': 'Mode: Advanced · Undergraduate.',
};

String packIdForDepth(String depth) {
  return switch (depth) {
    'beginner' => packBeginner,
    'advanced' => packAdvanced,
    _ => packIntermediate,
  };
}
