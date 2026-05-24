import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:skanfruits/core/config/app_config.dart';
import 'package:skanfruits/data/models/recognition_result.dart';

class FruitAnalyzerService {
  Interpreter? _interpreter;
  List<String>? _labels;

  /// Load the model and labels based on the selected mode
  Future<void> initialize(AIModelMode mode) async {
    final manifest = AppConfig.modelRegistry[mode];
    if (manifest == null || !manifest.isReady) {
      throw Exception('Model not found or not ready for mode: $mode');
    }

    try {
      // Load Interpreter
      _interpreter = await Interpreter.fromAsset(manifest.modelPath);
      
      // Load Labels
      final labelsData = await rootBundle.loadString(manifest.labelsPath);
      _labels = labelsData.split('\n').where((s) => s.isNotEmpty).toList();
      
      print('Model loaded: ${manifest.id}');
    } catch (e) {
      print('Error loading model: $e');
      rethrow;
    }
  }

  /// Run inference on a file (from gallery)
  Future<RecognitionResult> analyzeImage(File imageFile) async {
    if (_interpreter == null || _labels == null) {
      throw Exception('Service not initialized. Call initialize() first.');
    }

    // 1. Read and decode image
    final imageBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(imageBytes);
    if (image == null) throw Exception('Failed to decode image');

    // 2. Pre-process (Resize and Normalize)
    final input = _preprocess(image);

    // 3. Run Inference
    final output = List.filled(1 * _labels!.length, 0.0).reshape([1, _labels!.length]);
    _interpreter!.run(input, output);

    // 4. Process Output
    final results = output[0] as List<double>;
    return _getBestResult(results);
  }

  /// Pre-processing: Resize to 224x224 and normalize to [0, 1]
  /// MobileNetV2 usually expects 224x224x3
  List<List<List<List<double>>>> _preprocess(img.Image image) {
    final resizedImage = img.copyResize(image, width: 224, height: 224);
    
    // Create a 4D array [1, 224, 224, 3]
    var input = List.generate(
      1,
      (_) => List.generate(
        224,
        (_) => List.generate(
          224,
          (_) => List.filled(3, 0.0),
        ),
      ),
    );

    for (var y = 0; y < 224; y++) {
      for (var x = 0; x < 224; x++) {
        final pixel = resizedImage.getPixel(x, y);
        // Normalize 0-255 to 0-1
        input[0][y][x][0] = pixel.r / 255.0;
        input[0][y][x][1] = pixel.g / 255.0;
        input[0][y][x][2] = pixel.b / 255.0;
      }
    }

    return input;
  }

  RecognitionResult _getBestResult(List<double> probabilities) {
    var bestIndex = 0;
    var maxProb = -1.0;

    for (var i = 0; i < probabilities.length; i++) {
      if (probabilities[i] > maxProb) {
        maxProb = probabilities[i];
        bestIndex = i;
      }
    }

    return RecognitionResult(
      label: _labels![bestIndex],
      confidence: maxProb,
      index: bestIndex,
    );
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _labels = null;
  }
}
