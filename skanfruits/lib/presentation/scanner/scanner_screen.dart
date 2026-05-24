import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skanfruits/core/config/app_config.dart';
import 'package:skanfruits/core/config/app_theme.dart';
import 'package:skanfruits/presentation/scanner/scanner_controller.dart';
import 'package:skanfruits/presentation/result/result_screen.dart';

class ScannerScreen extends ConsumerWidget {
  const ScannerScreen({super.key});

  void _navigateToResult(BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          result: data['result'],
          imagePath: data['path'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scannerProvider);
    final controller = ref.read(scannerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera Preview
          _buildCameraPreview(state),

          // 2. Top Bar (Overlay)
          _buildTopBar(context, state, controller),

          // 3. Bottom Controls (Capture Button)
          _buildBottomControls(context, state, controller),

          // 4. Loading/Error Overlays
          if (state.isInitializing) _buildLoadingOverlay('Menyiapkan Kamera...'),
          if (state.isAnalyzing) _buildLoadingOverlay('Menganalisis Gambar...'),
          if (state.error != null) _buildErrorOverlay(state.error!),
        ],
      ),
    );
  }

  Widget _buildCameraPreview(ScannerState state) {
    if (state.cameraController == null || !state.cameraController!.value.isInitialized) {
      return Container(color: Colors.black);
    }

    return Center(
      child: AspectRatio(
        aspectRatio: 1 / state.cameraController!.value.aspectRatio,
        child: CameraPreview(state.cameraController!),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, ScannerState state, ScannerController controller) {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'skanfruit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final data = await controller.pickFromGallery();
                  if (data != null && context.mounted) {
                    _navigateToResult(context, data);
                  }
                },
                icon: const Icon(Icons.photo_library_rounded, color: Colors.white, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // AI Mode Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildModeButton(
                  'Cepat',
                  AIModelMode.fast,
                  state.currentMode == AIModelMode.fast,
                  () => controller.setModelMode(AIModelMode.fast),
                ),
                _buildModeButton(
                  'Akurat',
                  AIModelMode.accurate,
                  state.currentMode == AIModelMode.accurate,
                  () => controller.setModelMode(AIModelMode.accurate),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(String label, AIModelMode mode, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls(BuildContext context, ScannerState state, ScannerController controller) {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Capture Button
          GestureDetector(
            onTap: () async {
              final data = await controller.captureImage();
              if (data != null && context.mounted) {
                _navigateToResult(context, data);
              }
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: state.isAnalyzing 
                  ? const CircularProgressIndicator(color: Colors.black)
                  : null,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Guide Text
          const Text(
            'Klik tombol untuk mengambil gambar',
            style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay(String message) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 16),
            Text(
              message, 
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorOverlay(String error) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            const Text(
              'Terjadi Kesalahan',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(error, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Potential retry logic or reset error
              },
              child: const Text('Tutup'),
            )
          ],
        ),
      ),
    );
  }
}
