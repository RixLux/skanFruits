import 'package:skanfruits/core/constants/label_mapping.dart';

class RecognitionResult {
  /// The raw label from the TFLite model (e.g., 'freshapples')
  final String label;

  /// The confidence score of the prediction (0.0 to 1.0)
  final double confidence;

  /// The index of the predicted class in the labels list
  final int index;

  RecognitionResult({
    required this.label,
    required this.confidence,
    required this.index,
  });

  /// Translated Indonesian label
  String get readableLabel => LabelMapping.toReadable(label);

  /// Whether the fruit is classified as fresh
  bool get isFresh => LabelMapping.isFresh(label);

  /// Formatted confidence percentage string
  String get confidencePercentage => '${(confidence * 100).toStringAsFixed(1)}%';

  @override
  String toString() => 'RecognitionResult(label: $label, confidence: $confidence)';
}
