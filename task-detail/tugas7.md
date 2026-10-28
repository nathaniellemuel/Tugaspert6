# Tugas: Pertemuan 7 – Aplikasi Flutter "Data Poli" (Lanjutan Pertemuan 6)

## Konteks

Aplikasi Flutter (Material) untuk mengelola data **Poli** (poliklinik). Pertemuan 7 melanjutkan Pertemuan 6 dan berisi empat hal:

1. Memisahkan widget di `PoliForm` ke dalam method sendiri (`_fieldNamaPoli()` dan `_tombolSimpan()`).
2. Membuat tombol **Simpan** berfungsi: data dari `TextField` dikirim lewat `TextEditingController`, lalu ditampilkan di `PoliDetail`.
3. Membuat halaman **Form Ubah Poli** (`PoliUpdateForm`).
4. Mengubah `PoliDetail` menjadi `StatefulWidget` dengan tombol **Ubah** (hijau, membuka `PoliUpdateForm`) dan **Hapus** (merah, masih kosong).

## Asumsi project yang sudah ada (hasil Pertemuan 6)

Jangan dibuat ulang jika sudah ada. Jika belum ada, buat versi minimal.

- `lib/model/poli.dart` → class `Poli` dengan field `String namaPoli`, constructor named param: `Poli(namaPoli: "...")`.
- `lib/ui/poli_page.dart` → halaman list poli (memakai `PoliItem`, AppBar punya ikon `+` yang membuka `PoliForm`).
- `lib/ui/poli_item.dart` → `PoliItem`, tap membuka `PoliDetail`.
- `lib/ui/poli_form.dart` → `PoliForm` (versi Pertemuan 6: satu `TextField` dan tombol Simpan kosong).
- `lib/ui/poli_detail.dart` → `PoliDetail` (versi awal, akan diubah di Langkah 4).
- Semua file UI ada di `lib/ui/`, model di `lib/model/`.
- Dart/Flutter versi modern.

## Struktur file akhir

```
lib/
├── model/
│   └── poli.dart
└── ui/
    ├── poli_page.dart          (tidak diubah)
    ├── poli_item.dart          (tidak diubah)
    ├── poli_form.dart          (DIUBAH – Langkah 1 & 2)
    ├── poli_detail.dart        (DIUBAH – Langkah 4)
    └── poli_update_form.dart   (BARU – Langkah 3)
```

## Catatan penting soal import

Materi memakai dua gaya import yang berbeda dan satu di antaranya typo. Aturan yang dipakai di tugas ini:

- Nama package di materi adalah `klinikapp` (`package:klinikapp/model/poli.dart`). **Cek nama package yang sebenarnya di `pubspec.yaml`.** Kalau berbeda, sesuaikan, atau pakai import relatif (`../model/poli.dart`, `poli_detail.dart`), yang selalu aman.
- Di materi Form Ubah ada tulisan `import ' /ui/poli_detail.dart';` (ada spasi di depan dan path salah). Itu typo. Karena `poli_update_form.dart` berada satu folder dengan `poli_detail.dart`, pakai `import 'poli_detail.dart';`.

---

## Langkah 1 – Pisahkan widget `PoliForm` ke dalam method

**Latar belakang:** Agar kode mudah dibaca dan dikembangkan, widget seperti `TextField` dan `ElevatedButton` dipisahkan ke method sendiri di dalam class state.

**Edit file:** `lib/ui/poli_form.dart`

```dart
import 'package:flutter/material.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({Key? key}) : super(key: key);
  _PoliFormState createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Poli")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [_fieldNamaPoli(), SizedBox(height: 20), _tombolSimpan()],
          ),
        ),
      ),
    );
  }

  _fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () {},
        child: const Text("Simpan"));
  }
}
```

**Hasil yang diharapkan:** Tampilan form sama persis dengan Pertemuan 6, hanya struktur kodenya yang lebih rapi.

---

## Langkah 2 – Fungsi tombol Simpan dan tampilkan data di Detail Poli

**Latar belakang:** Data yang diketik di `TextField` ditangkap memakai `TextEditingController`. Saat tombol Simpan ditekan, dibuat objek `Poli` dari isi controller, lalu halaman diganti ke `PoliDetail` dengan data tersebut.

**Edit file:** `lib/ui/poli_form.dart` (menggantikan versi Langkah 1)

Perubahan dari Langkah 1:
1. Tambah import `poli.dart` dan `poli_detail.dart`.
2. Tambah atribut `final _namaPoliCtrl = TextEditingController();`.
3. `_fieldNamaPoli()` diberi `controller: _namaPoliCtrl`.
4. `_tombolSimpan()` mengisi `onPressed` dengan membuat `Poli` lalu `Navigator.pushReplacement` ke `PoliDetail`.

```dart
import 'package:flutter/material.dart';
import 'package:klinikapp/model/poli.dart';
import 'package:klinikapp/ui/poli_detail.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({Key? key}) : super(key: key);
  _PoliFormState createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Poli")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [_fieldNamaPoli(), SizedBox(height: 20), _tombolSimpan()],
          ),
        ),
      ),
    );
  }

  _fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: _namaPoliCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () {
          Poli poli = new Poli(namaPoli: _namaPoliCtrl.text);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PoliDetail(poli: poli)));
        },
        child: const Text("Simpan"));
  }
}
```

**Hasil yang diharapkan:** Ketik "Poli Kandungan" di form lalu tekan Simpan. Halaman berpindah ke Detail Poli yang menampilkan `Nama Poli : Poli Kandungan`.

> Kalau nama package bukan `klinikapp`, ganti dua baris import package di atas (lihat bagian "Catatan penting soal import").

---

## Langkah 3 – Buat Form Ubah Poli

**Latar belakang:** Halaman Detail Poli akan punya tombol Ubah. Saat ditekan, pengguna diarahkan ke Form Ubah Poli yang sudah terisi data poli yang akan diubah.

**Buat file:** `lib/ui/poli_update_form.dart`

```dart
import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';

class PoliUpdateForm extends StatefulWidget {
  final Poli poli;

  const PoliUpdateForm({Key? key, required this.poli}) : super(key: key);
  _PoliUpdateFormState createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PoliUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _namaPoliCtrl.text = widget.poli.namaPoli;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Poli")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [_fieldNamaPoli(), SizedBox(height: 20), _tombolSimpan()],
          ),
        ),
      ),
    );
  }

  _fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: _namaPoliCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () {
          Poli poli = new Poli(namaPoli: _namaPoliCtrl.text);
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PoliDetail(poli: poli)));
        },
        child: const Text("Simpan Perubahan"));
  }
}
```

**Penjelasan:**
- Class menerima `final Poli poli;` lewat constructor (`required this.poli`).
- Di `initState()`, controller diisi `widget.poli.namaPoli` sehingga form langsung menampilkan data lama.
- Tombol "Simpan Perubahan" membuat `Poli` baru dari isi controller, menutup form (`pop`), lalu mengganti halaman detail dengan data terbaru (`pushReplacement`).
- Title AppBar: "Ubah Poli".

---

## Langkah 4 – Ubah `PoliDetail` (tambah tombol Ubah dan Hapus)

**Latar belakang:** Halaman Detail Poli ditambah dua tombol. Tombol Ubah membuka `PoliUpdateForm`, sedangkan tombol Hapus belum punya fungsi. Tiap tombol dipisah ke method sendiri.

**Edit file:** `lib/ui/poli_detail.dart` (ganti seluruh isi)

```dart
import 'package:flutter/material.dart';
import 'poli_update_form.dart';
import '../model/poli.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;

  const PoliDetail({super.key, required this.poli});

  @override
  State<PoliDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Poli")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Nama Poli : ${widget.poli.namaPoli}",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _tombolUbah(),
              _tombolHapus(),
            ],
          )
        ],
      ),
    );
  }

  _tombolUbah() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PoliUpdateForm(poli: widget.poli)));
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text("Ubah"));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }
}
```

**Hasil yang diharapkan:**
- Detail Poli menampilkan teks `Nama Poli : <nama>` dan dua tombol sejajar: **Ubah** (hijau) dan **Hapus** (merah).
- Tombol Ubah membuka Form Ubah Poli dengan field sudah terisi nama poli.
- Tombol Hapus belum melakukan apa-apa (`onPressed: () {}`).

---

## Alur lengkap yang harus bisa dicoba

1. Buka halaman Data Poli, tekan ikon `+` di AppBar. Form **Tambah Poli** terbuka.
2. Isi "Poli Kandungan", tekan **Simpan**. Halaman berganti ke **Detail Poli** dengan `Nama Poli : Poli Kandungan`.
3. Tekan **Ubah**. Form **Ubah Poli** terbuka dengan field terisi "Poli Kandungan".
4. Ubah nama, tekan **Simpan Perubahan**. Halaman Detail Poli muncul dengan nama terbaru.
5. Tombol **Hapus** tidak melakukan apa-apa.

## Kriteria selesai

- `flutter pub get` dan `flutter analyze` tanpa error (warning atau info dari gaya kode materi boleh diabaikan).
- Aplikasi berjalan dan alur di atas bisa dicoba dari awal sampai akhir.
- `poli_form.dart` memakai method `_fieldNamaPoli()` dan `_tombolSimpan()`.
- `poli_update_form.dart` ada di `lib/ui/` dan data lama muncul di field saat dibuka.
- `PoliDetail` memiliki `_tombolUbah()` (hijau) dan `_tombolHapus()` (merah).
- Halaman list Poli dan `PoliItem` tetap berjalan seperti Pertemuan 6.

## Catatan untuk AI agent

- Ikuti kode di atas apa adanya. Jangan tambah database, state management, validasi, atau fitur hapus yang sebenarnya, karena belum diminta di pertemuan ini.
- Jangan ubah `poli_page.dart`, `poli_item.dart`, dan `poli.dart` kecuali ada error kompilasi.
- Kalau ada file dari Pertemuan 6 yang belum ada, buat versi minimal yang konsisten dengan bagian "Asumsi project".
- Setelah selesai, tampilkan ringkasan file yang dibuat dan diubah.

---

## (Opsional) Terapkan juga ke Pegawai dan Pasien

Hapus bagian ini kalau tugas Pertemuan 7 hanya untuk Poli.

Kalau dosen meminta pola yang sama untuk **Pegawai** dan **Pasien** (skema dari tugas Pertemuan 6), ulangi Langkah 1–4 dengan perubahan berikut:

- Buat `pegawai_update_form.dart` dan `pasien_update_form.dart` di `lib/ui/`.
- Di `*_form.dart` dan `*_update_form.dart`, buat satu `TextEditingController` dan satu method `_fieldXxx()` untuk **setiap field** (kecuali `id`), ditambah `_tombolSimpan()`.
- Di `*_update_form.dart`, isi semua controller di `initState()` dari objek yang diterima.
- Di `*_detail.dart`, jadikan `StatefulWidget` dengan `_tombolUbah()` (hijau) dan `_tombolHapus()` (merah, kosong). Tampilkan semua field satu baris per field. Untuk Pegawai, password tetap ditampilkan sebagai "••••••••".
- Field password memakai `obscureText: true`.
- Tombol Simpan membuat objek model dari isi semua controller, lalu `pushReplacement` ke halaman detail.