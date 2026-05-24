# Product Requirement Document (PRD)

**Nama Proyek:** skanfruit

**Platform:** Mobile (Android & iOS via Flutter)

**Teknologi Utama:** Flutter, TensorFlow Lite (Kuantisasi), MobileNetV2

---

## 1. Ringkasan Eksekutif & Tujuan (Objective)

??? info "Click to see details"
    Aplikasi ini bertujuan untuk mendeteksi kualitas dan kesegaran 9 jenis buah (total 18 kelas termasuk kondisi segar vs busuk) secara *real-time* langsung menggunakan kamera HP. Aplikasi ini memberikan transparansi penuh kepada pengguna dengan mengizinkan mereka memilih mode kecerdasan AI (Mode Cepat vs Mode Akurat) sesuai dengan spesifikasi perangkat atau kebutuhan akurasi mereka.

    ---

## 2. Target Pengguna (User Persona)

??? info "Click to see details"
    1. **Pengguna Awam / Konsumen Rumah Tangga:** Memastikan buah yang dibeli dalam kondisi segar.
    2. **Pedagang Buah Kecil/UMKM:** Membantu menyortir stok buah harian dengan cepat tanpa alat mahal.
    3. **Antusias AI / Penguji (Developer/Akademisi):** Membandingkan performa model AI hasil variasi *training* secara langsung di perangkat mobile.

    ---

## 3. Fitur Utama & Kebutuhan Fungsional

??? info "Klik di sini untuk melihat detail"  
    ### FR-1: Manajemen Aset & Multi-Model AI
    * **FR-1.1:** Aplikasi harus memuat file model format `.tflite` (Kuantisasi) dan file `labels.txt` dari penyimpanan lokal (`assets/`).
    * **FR-1.2:** Aplikasi wajib menerapkan isolasi memori (*dispose*) saat model tidak digunakan agar menghemat RAM perangkat.
    * **FR-1.3:** Aplikasi harus mendukung fitur *Hot-Swapping Model* (mengubah model aktif di latar belakang tanpa perlu me-restart aplikasi).
    * **FR-1.4:** **Sentralisasi Registry Model:** Seluruh daftar jalur aset model, nama tampilan mode, dan meta-data pendukung wajib didaftarkan pada satu file konfigurasi sentral. Penambahan model eksperimen baru tidak boleh mengubah kode pada lapisan UI.

    ### FR-2: Antarmuka Pemilihan Mode AI (User Delegation)
    * **FR-2.1:** Menyediakan *Toggle/Segmented Control* di layar utama agar pengguna dapat memilih mode:
    * **Mode Cepat (Model 10 Epochs):** Inferensi kilat, konsumsi RAM super rendah.
    * **Mode Akurat (Model 20 Epochs):** Akurasi lebih tinggi, direkomendasikan untuk HP kelas menengah atas *(Upcoming / Berstatus terkunci di UI jika file model belum tersedia)*.


    * **FR-2.2:** Menyediakan teks deskripsi dinamis yang menjelaskan konsekuensi pemilihan mode kepada pengguna awam.

    ### FR-3: Pemindaian Gambar & Pre-processing
    * **FR-3.1:** **Mode Kamera Langsung:** Integrasi dengan kamera perangkat untuk mendeteksi buah secara langsung (*live preview inference*).
    * **FR-3.2:** **Fitur Capture Manual [BARU]:** Selain live preview, aplikasi harus menyediakan tombol "Capture" (tangkap gambar) secara manual pada antarmuka kamera untuk membekukan momen dan memulai analisis mendalam.
    * **FR-3.3:** **Mode Galeri:** Pengguna dapat mengunggah foto buah yang sudah ada di galeri ponsel.
    * **FR-3.4:** **Transisi Hasil [BARU]:** Segera setelah gambar diambil (via capture manual atau gallery), aplikasi wajib melakukan transisi navigasi (berpindah halaman) ke halaman `ResultScreen` untuk menampilkan analisis lengkap.
    * **FR-3.5:** **Pre-processing Otomatis:** Sistem Flutter harus otomatis melakukan *resize* gambar masukan ke ukuran $224 \times 224$ piksel (sesuai spesifikasi *training*) dan melakukan normalisasi nilai piksel sebelum diumpankan ke model TFLite.

    ### FR-4: Tampilan Hasil Analisis (Inference Output)
    * **FR-4.1:** **ResultScreen (Full Page) [BARU]:** Hasil analisis akhir wajib ditampilkan dalam satu halaman penuh (`ResultScreen`), bukan lagi menggunakan modal pop-up. Modal pop-up hanya digunakan sementara sebagai feedback instan (misal: "Memproses gambar...", "Terjadi kesalahan").
    * **FR-4.2:** **Logika Saringan Akurasi (Threshold 80%) [BARU]:**
        *   Jika *Confidence Score* $\ge 80\%$: Tampilkan hasil klasifikasi normal (Nama buah dan status kesegaran).
        *   Jika *Confidence Score* $< 80\%$: Tampilkan pesan peringatan: *"Model menduga ini adalah [Nama_Buah], namun dugaan ini mungkin salah karena tingkat keyakinan rendah. Pastikan objek adalah buah dan dekatkan kamera."*
    * **FR-4.3:** Menampilkan label hasil klasifikasi dengan translasi otomatis bahasa Indonesia melalui kamus pemetaan terpusat (Contoh: `freshapples` $\rightarrow$ "Apel Segar").
    * **FR-4.4:** Menampilkan nilai kepercayaan tingkat akurasi (*Confidence Score*) dalam bentuk persentase.
    * **FR-4.5:** Memberikan penanda warna visual: Hijau untuk buah segar (`fresh...`) dan Merah untuk buah busuk (`rotten...`).

    ### FR-5: Kustomisasi Branding & Gaya (Easy Styling)
    * **FR-5.1:** **Manajemen Ikon Otomatis:** Sistem wajib dikonfigurasi menggunakan *automation engine* (`flutter_launcher_icons`).
    * **FR-5.2:** **Native Splash Screen:** Layar pembuka (*splash screen*) harus dikonfigurasi secara native (`flutter_native_splash`).
    * **FR-5.3:** **Sistem Tema Terpusat (Global Theme):** Seluruh kode warna aplikasi harus mengambil nilai dari satu file konfigurasi tema sentral (`app_theme.dart`).

---

## 4. Struktur Arsitektur Kode

<details>
<summary>click to expand</summary>

```text
lib/
├── core/                     
│    ├── config/
│    │    ├── app_config.dart 
│    │    └── app_theme.dart  
│    └── constants/
│         └── label_mapping.dart 
├── data/
│    ├── models/
│    │    └── recognition_result.dart 
│    └── services/
│         └── fruit_analyzer_service.dart 
├── presentation/
│    ├── scanner/
│    │    ├── scanner_screen.dart     
│    │    └── scanner_controller.dart 
│    ├── result/
│    │    └── result_screen.dart [BARU]
│    └── widgets/
│         └── loading_modal.dart [BARU]
└── main.dart
```

</details>

---

## 5. Kebutuhan Non-Fungsional (Non-Functional Requirements)

??? info "Click to see details"
    * **Performa Kecepatan:** Waktu deteksi (inferensi) tidak boleh lebih dari 500ms pada Mode Cepat di HP kelas *entry-level*.
    * **Ukuran Aplikasi:** Ukuran total APK/IPA setelah di-build tidak boleh melebihi 50 MB.
    * **Ketersediaan Offline:** Aplikasi harus berfungsi 100% tanpa koneksi internet (*on-device AI*).

    ---

## 6. Rencana Pengujian (Test Plan)

??? info "Click to see details"
    1. **Uji Threshold Akurasi:** Menguji model dengan gambar non-buah atau gambar blur untuk memastikan pesan peringatan muncul jika confidence score di bawah 80%.
    2. **Uji Navigasi:** Memastikan transisi dari `ScannerScreen` ke `ResultScreen` berjalan mulus setelah proses capture atau gallery pick.
    3. **Uji Kebocoran Memori:** Memastikan pembersihan memori dilakukan dengan benar saat berpindah-pindah halaman.

