import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skanfruits/core/config/app_config.dart';
import 'package:skanfruits/data/models/recognition_result.dart';
import 'package:skanfruits/data/services/fruit_analyzer_service.dart';

/// State for the Scanner
class ScannerState {
  final bool isInitializing;
  final CameraController? cameraController;
  final RecognitionResult? lastResult;
  final AIModelMode currentMode;
  final bool isAnalyzing;
  final String? error;
  final String? lastCapturedImagePath;

  ScannerState({
    this.isInitializing = true,
    this.cameraController,
    this.lastResult,
    this.currentMode = AppConfig.defaultMode,
    this.isAnalyzing = false,
    this.error,
    this.lastCapturedImagePath,
  });

  ScannerState copyWith({
    bool? isInitializing,
    CameraController? cameraController,
    RecognitionResult? lastResult,
    AIModelMode? currentMode,
    bool? isAnalyzing,
    String? error,
    String? lastCapturedImagePath,
  }) {
    return ScannerState(
      isInitializing: isInitializing ?? this.isInitializing,
      cameraController: cameraController ?? this.cameraController,
      lastResult: lastResult ?? this.lastResult,
      currentMode: currentMode ?? this.currentMode,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      error: error ?? this.error,
      lastCapturedImagePath: lastCapturedImagePath ?? this.lastCapturedImagePath,
    );
  }
}

/// Controller for the Scanner logic
class ScannerController extends StateNotifier<ScannerState> {
  final FruitAnalyzerService _analyzerService = FruitAnalyzerService();
  final ImagePicker _picker = ImagePicker();
  
  // To prevent overlapping inference
  bool _isProcessingFrame = false;
  DateTime _lastInferenceTime = DateTime.now();
  static const _inferenceIntervalMs = 800; // Throttle to every 800ms

  ScannerController() : super(ScannerState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      state = state.copyWith(isInitializing: true, error: null);
      
      // 1. Initialize AI Service
      await _analyzerService.initialize(state.currentMode);

      // 2. Initialize Camera
      final cameras = await availableCameras();
      if (cameras.isEmpty) throw Exception('No cameras found');

      final controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid 
            ? ImageFormatGroup.yuv420 
            : ImageFormatGroup.bgra8888,
      );

      await controller.initialize();
      
      // 3. Start Image Stream for Live Inference (Optional in 1.1.0, but keeping it)
      // controller.startImageStream(_processCameraImage);

      state = state.copyWith(
        isInitializing: false,
        cameraController: controller,
      );
    } catch (e) {
      state = state.copyWith(isInitializing: false, error: e.toString());
    }
  }

  /// Toggle between Fast and Accurate mode
  Future<void> setModelMode(AIModelMode mode) async {
    if (state.currentMode == mode) return;

    state = state.copyWith(isAnalyzing: true);
    await _analyzerService.initialize(mode);
    state = state.copyWith(currentMode: mode, isAnalyzing: false);
  }

  /// Capture image from camera and analyze
  Future<Map<String, dynamic>?> captureImage() async {
    if (state.cameraController == null || !state.cameraController!.value.isInitialized) {
      return null;
    }

    try {
      state = state.copyWith(isAnalyzing: true);
      
      final XFile photo = await state.cameraController!.takePicture();
      final result = await _analyzerService.analyzeImage(File(photo.path));
      
      state = state.copyWith(
        isAnalyzing: false,
        lastResult: result,
        lastCapturedImagePath: photo.path,
      );

      return {
        'result': result,
        'path': photo.path,
      };
    } catch (e) {
      state = state.copyWith(isAnalyzing: false, error: 'Capture Error: $e');
      return null;
    }
  }

  /// Pick image from gallery and analyze
  Future<Map<String, dynamic>?> pickFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      state = state.copyWith(isAnalyzing: true);
      final result = await _analyzerService.analyzeImage(File(pickedFile.path));
      
      state = state.copyWith(
        isAnalyzing: false,
        lastResult: result,
        lastCapturedImagePath: pickedFile.path,
      );

      return {
        'result': result,
        'path': pickedFile.path,
      };
    } catch (e) {
      state = state.copyWith(isAnalyzing: false, error: 'Gallery Error: $e');
      return null;
    }
  }

  /// Process live camera frames
  void _processCameraImage(CameraImage image) async {
    // Throttle and check if already processing
    final now = DateTime.now();
    if (_isProcessingFrame || 
        now.difference(_lastInferenceTime).inMilliseconds < _inferenceIntervalMs) {
      return;
    }

    _isProcessingFrame = true;
    _lastInferenceTime = now;

    try {
      // NOTE: For live stream, we might need a separate method in FruitAnalyzerService 
      // that converts CameraImage directly to the required input format.
      // For simplicity in this v0.3.0, we will keep the structure ready for it.
      
      // TODO: Implement direct CameraImage to TFLite input conversion in service
      // For now, this is a placeholder for the live logic
    } catch (e) {
      print('Stream inference error: $e');
    } finally {
      _isProcessingFrame = false;
    }
  }

  @override
  void dispose() {
    state.cameraController?.dispose();
    _analyzerService.dispose();
    super.dispose();
  }
}

final scannerProvider = StateNotifierProvider<ScannerController, ScannerState>((ref) {
  return ScannerController();
});
