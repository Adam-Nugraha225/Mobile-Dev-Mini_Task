# Mini Task Tracker / Catatan Harian Sederhana

Aplikasi mobile berbasis Flutter untuk mencatat daftar tugas dan catatan harian secara praktis dan responsif. Dibuat sebagai pemenuhan penugasan seleksi studi kasus Mobile Developer Study Group / Laboratorium Motion.

---

## 📌 Identitas Peserta
- **Nama:** [Masukkan Nama Lengkap Anda]
- **NIM:** [Masukkan NIM Anda]
- **Platform:** Flutter (Dart)

---

## 📱 Fitur Utama Aplikasi (Core Requirements)
1. **Input Data**:
   - Kolom teks (`TextField`) untuk memasukkan judul catatan/tugas baru.
   - Tombol **Simpan** untuk menambahkan tugas ke dalam daftar.
   - Dilengkapi validasi otomatis (mencegah penyimpanan teks kosong).
2. **Tampilan Daftar (List)**:
   - Menampilkan seluruh catatan yang sudah dimasukkan menggunakan `ListView.builder`.
   - Menampilkan waktu pembuatan catatan.
   - Disertai *Empty State View* yang rapi saat belum ada catatan yang dibuat.
   - Ringkasan indikator progres jumlah tugas yang selesai di bagian AppBar.
3. **Aksi Sederhana**:
   - **Tandai Selesai**: Checkbox untuk menandai tugas telah rampung (dilengkapi efek visual *strikethrough* / teks tercoret).
   - **Hapus Catatan**: Tombol hapus dengan konfirmasi dialog (*AlertDialog*) untuk mencegah penghapusan yang tidak disengaja, serta fitur *Undo* (Batalkan) via SnackBar.
4. **State Management**:
   - Menggunakan state lokal bawaan Flutter (`StatefulWidget` & `setState()`) dengan penyimpanan data *in-memory*.

---

## 📸 Demo & Tampilan Aplikasi

> *Catatan: Letakkan screenshot aplikasi yang sedang berjalan di folder `screenshots/` atau lampirkan gambar di bawah ini.*

| Tampilan Utama (Kosong) | Tampilan Daftar Tugas | Aksi Centang & Hapus |
| :---: | :---: | :---: |
| *(Screenshot Empty State)* | *(Screenshot List Tugas)* | *(Screenshot Aksi / Dialog)* |

---

## 🚀 Langkah Menjalankan Aplikasi (How to Run)

Pastikan Flutter SDK telah terpasang di komputer Anda.

1. **Clone Repositori ini:**
   ```bash
   git clone https://github.com/[username-anda]/[nama-repo].git
   cd [nama-repo]
   ```

2. **Unduh Dependensi:**
   ```bash
   flutter pub get
   ```

3. **Jalankan Aplikasi:**
   Hubungkan perangkat Android fisik (via USB debugging) atau jalankan Android Emulator, lalu eksekusi:
   ```bash
   flutter run
   ```

4. **Build File APK:**
   Untuk menghasilkan file `.apk` siap pasang:
   ```bash
   flutter build apk --release
   ```
   File hasil build akan berada di direktori:
   `build/app/outputs/flutter-apk/app-release.apk`

---

## 📂 Struktur Direktori Proyek

Proyek ini menerapkan pemisahan file modular (*Clean Code*) agar mudah dipelihara dan dipahami:

```text
lib/
├── models/
│   └── task_model.dart       # Blueprint objek data Task (id, title, isCompleted, createdAt)
├── widgets/
│   ├── empty_state.dart      # Widget tampilan saat daftar tugas masih kosong
│   └── task_tile.dart        # Komponen kartu item per catatan (Checkbox, Teks, Tombol Hapus)
├── screens/
│   └── home_screen.dart      # Halaman utama pengelola state (setState, validasi, aksi)
└── main.dart                 # Titik awal masuk aplikasi (konfigurasi tema Material 3)
```

---

### Deklarasi Penggunaan AI

- Apakah menggunakan AI? Ya
- Tool AI yang digunakan: Antigravity (Google DeepMind)
- Estimasi persentase kontribusi AI: 35 % (Maksimal 40%)
- Bagian kode/fitur yang dibantu AI:
  - Referensi struktur folder modular (*Clean Code*).
  - Referensi penataan UI Material 3 dan komponen Empty State.
  - Asistensi debugging struktur data in-memory dan konfirmasi dialog.
- Pernyataan:
  "Saya menyatakan bahwa saya memahami alur dan fungsi dari seluruh kode yang ada dalam repositori ini"
