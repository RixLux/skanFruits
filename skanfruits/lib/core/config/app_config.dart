enum AIModelMode { fast, accurate, experimental }

class ModelManifest {
  final String id;
  final String displayName;
  final String description;
  final String modelPath;
  final String labelsPath;
  final bool isReady;
  final String version;

  ModelManifest({
    required this.id,
    required this.displayName,
    required this.description,
    required this.modelPath,
    required this.labelsPath,
    this.isReady = true,
    this.version = '1.0.0',
  });
}

class AppConfig {
  static const String appName = 'skanfruit';
  static const String appVersion = '0.1.0';

  // Default AI Model Mode
  static const AIModelMode defaultMode = AIModelMode.fast;

  // Central Registry for AI Models
  static final Map<AIModelMode, ModelManifest> modelRegistry = {
    AIModelMode.fast: ModelManifest(
      id: 'mobilenet_v2_quant_e10',
      displayName: 'Mode Cepat',
      description: 'Pemrosesan kilat, hemat baterai dan RAM.',
      modelPath: 'assets/models/fruit_quality/fruit_quality_quantized.tflite',
      labelsPath: 'assets/models/fruit_quality/labels.txt',
      version: '1.0.0',
    ),
    AIModelMode.accurate: ModelManifest(
      id: 'mobilenet_v2_quant_e20',
      displayName: 'Mode Akurat',
      description: 'Analisis mendalam, akurasi klasifikasi lebih tinggi.',
      modelPath: 'assets/models/fruit_quality/fruit_quality_accurate.tflite', // Upcoming
      labelsPath: 'assets/models/fruit_quality/labels.txt',
      isReady: false,
      version: '1.0.0',
    ),
  };
}
