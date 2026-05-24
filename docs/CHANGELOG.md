# Changelog

Semua perubahan signifikan pada proyek **skanfruit** akan dicatat di dokumen ini.

## [1.1.0] - 2026-05-24

??? info "Click to see detail"
    ### Added
    - **ResultScreen:** Halaman baru untuk menampilkan hasil analisis secara penuh dan detail, menggantikan modal pop-up.
    - **Manual Capture:** Opsi tombol tangkap gambar (capture) pada kamera untuk kontrol pengguna yang lebih baik.
    - **Loading Feedback:** Modal transisi instan untuk memberikan umpan balik saat proses analisis gambar sedang berlangsung.

    ### Changed
    - **Navigation Flow:** Alur aplikasi sekarang berpindah halaman ke `ResultScreen` setelah mengambil gambar dari kamera atau galeri.
    - **Confidence Thresholding:** Implementasi logika saringan akurasi 80%. Jika hasil di bawah 80%, aplikasi akan menampilkan pesan peringatan khusus mengenai potensi kesalahan identifikasi.
    - **UX Improvement:** Penghapusan modal pop-up hasil akhir demi tampilan yang lebih profesional dan terfokus.

## [1.0.0] - 2026-05-24

??? info "Click to see detail"
    ### Added
    - **Final Branding:** Konfigurasi `flutter_launcher_icons` dan `flutter_native_splash`.
    - **Optimization:** Audit performa pada `ScannerController` dan pembersihan memori pada `FruitAnalyzerService`.
    - **Master Plan Completion:** Seluruh fase pengembangan selesai.

## [0.4.x] - 2026-05-24

??? info "Click to see detail"
    ### Added
    - **UI/UX Refinement:** Implementasi `Mode Selector` (Cepat vs Akurat) di layar utama.
    - **Enhanced Result Card:** Desain kartu hasil dengan glow efek, progress bar untuk confidence score, dan ikon status.
    - **Visual Feedback:** Animasi loading saat proses analisis dan instruksi panduan bagi pengguna.

## [0.3.x] - 2026-05-24

??? info "Click to see detail"
    ### Added
    - **Camera Integration:** Implementasi stream kamera langsung menggunakan package `camera`.
    - **Gallery Feature:** Integrasi `image_picker` untuk menganalisis gambar dari penyimpanan ponsel.
    - **Frame Throttling:** Sistem jeda inferensi (800ms) untuk menghemat penggunaan baterai dan CPU.

## [0.2.x] - 2026-05-24

??? info "Click to see detail"
    ### Added
    - **AI Core:** Implementasi `FruitAnalyzerService` untuk memuat model `.tflite`.
    - **Image Pre-processing:** Logika resize gambar ke $224 \times 224$ dan normalisasi piksel $[0, 1]$.
    - **Data Model:** Pembuatan `RecognitionResult` untuk standarisasi output inferensi.

## [0.1.x] - 2026-05-24

??? info "Click to see detail"
    ### Added
    - **Project Initialization:** Setup struktur folder (core, data, presentation).
    - **Centralized Config:** Implementasi `AppConfig` (registry model) dan `AppTheme` (branding warna/font).
    - **Localization Mapping:** Pemetaan 18 kelas label TFLite ke Bahasa Indonesia melalui `LabelMapping`.

