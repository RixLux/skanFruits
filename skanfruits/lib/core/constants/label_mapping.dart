class LabelMapping {
  static const Map<String, String> indonesianLabels = {
    'freshapples': 'Apel Segar',
    'freshbanana': 'Pisang Segar',
    'freshbittergroud': 'Pare Segar',
    'freshcapsicum': 'Paprika Segar',
    'freshcucumber': 'Timun Segar',
    'freshokra': 'Okra Segar',
    'freshoranges': 'Jeruk Segar',
    'freshpotato': 'Kentang Segar',
    'freshtomato': 'Tomat Segar',
    'rottenapples': 'Apel Busuk',
    'rottenbanana': 'Pisang Busuk',
    'rottenbittergroud': 'Pare Busuk',
    'rottencapsicum': 'Paprika Busuk',
    'rottencucumber': 'Timun Busuk',
    'rottenokra': 'Okra Busuk',
    'rottenoranges': 'Jeruk Busuk',
    'rottenpotato': 'Kentang Busuk',
    'rottentomato': 'Tomat Busuk',
  };

  /// Returns true if the raw label indicates a fresh fruit
  static bool isFresh(String rawLabel) {
    return rawLabel.toLowerCase().startsWith('fresh');
  }

  /// Translates the raw TFLite label to a human-readable Indonesian string
  static String toReadable(String rawLabel) {
    // Normalize input (remove potential leading/trailing spaces or case sensitivity)
    final normalized = rawLabel.trim().toLowerCase();
    return indonesianLabels[normalized] ?? 'Objek Tidak Dikenali';
  }
}
