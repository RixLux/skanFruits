# Master Development Plan: skanfruit

Dokumen ini berisi tahapan eksekusi proyek **skanfruit** berdasarkan PRD. Pengembangan dibagi menjadi fase-fase terukur dengan sistem versioning `0.0.0`.

---

## Fase 1: Foundation & Core Configuration (v0.1.x) ✅

<details markdown="1">
<summary>Click to see details</summary>

**Tujuan:** Membangun struktur folder dan sistem konfigurasi sentral agar UI tidak bergantung pada logika AI.

---

</details>

## Fase 2: AI Engine & Data Layer (v0.2.x) ✅

<details markdown="1">
<summary>Click to see details</summary>

**Tujuan:** Mengintegrasikan TFLite dan memastikan model bisa dimuat serta diproses dengan benar.

---

</details>

## Fase 3: Camera & Image Scanning (v0.3.x) ✅

<details markdown="1">
<summary>Click to see details</summary>

**Tujuan:** Implementasi fitur pemindaian secara real-time dan dari galeri.

---

</details>

## Fase 4: User Interface & Experience (v0.4.x) ✅

<details markdown="1">
<summary>Click to see details</summary>

**Tujuan:** Mempercantik tampilan dan memberikan feedback visual kepada pengguna.

---

</details>

## Fase 5: Branding, Optimization & Launch (v1.0.0) ✅

<details markdown="1">
<summary>Click to see details</summary>

**Tujuan:** Persiapan rilis dengan aset profesional dan performa yang optimal.

---

</details>

## Fase 1.1.0: Optimalisasi Alur UI & Penanganan Objek Non-Buah (v1.1.0-draft) 

<details markdown="1">
<summary>Click to see details</summary>

**Tujuan:** Memperbaiki alur navigasi dan akurasi informasi sebelum update besar ke Object Detection.

### v1.1.0: UI Refinement & Thresholding
- [x] **Rombak Alur Navigasi:**
    - [x] Pembuatan `ResultScreen` sebagai halaman penuh untuk menampilkan detail analisis.
    - [x] Implementasi tombol "Capture" manual pada `ScannerScreen`.
    - [x] Navigasi otomatis ke `ResultScreen` setelah pengambilan gambar (Kamera/Galeri).
- [x] **Logika Threshold 80%:**
    - [x] Penambahan logika kondisional pada `ScannerController` atau `FruitAnalyzerService`: `if (confidence < 0.80)`.
    - [x] Implementasi UI peringatan khusus pada `ResultScreen` untuk hasil dengan keyakinan rendah.
- [x] **Feedback Instan:**
    - [x] Implementasi modal loading sederhana saat proses analisis berlangsung sebelum transisi halaman.

---

</details>

## Catatan Perubahan (Changelog)

<details markdown="1">
<summary>Click to see details</summary>

- **v1.1.0-draft:** Penambahan fase optimalisasi alur UI dan thresholding akurasi.
- **v1.0.0:** Proyek dasar selesai. Seluruh fitur utama telah diimplementasikan.
- **v0.0.0:** Inisiasi dokumen Master Plan.

</details>

