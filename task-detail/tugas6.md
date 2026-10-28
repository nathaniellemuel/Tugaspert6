# Tugas: Pertemuan 6 – Aplikasi Flutter "Data Poli"

## Konteks

Aplikasi Flutter (Material) untuk mengelola data **Poli** (poliklinik). Pertemuan 6 berisi tiga hal:

1. Memisahkan item list poli menjadi widget sendiri (`PoliItem`).
2. Menyederhanakan `PoliPage` dengan memakai `PoliItem`.
3. Membuat halaman form tambah poli (`PoliForm`) dan membukanya dari tombol `+` di AppBar `PoliPage`.

## Asumsi project yang sudah ada (dari pertemuan sebelumnya)

Jangan dibuat ulang jika sudah ada. Jika belum ada, buat versi minimal.

- `lib/model/poli.dart` → class `Poli` dengan field `String namaPoli` (constructor named param: `Poli(namaPoli: "...")`).
- `lib/ui/poli_detail.dart` → class `PoliDetail` dengan constructor `PoliDetail({required Poli poli})`, menampilkan detail poli.
- `lib/ui/poli_page.dart` → halaman list poli (versi awal memakai `ListView` dengan beberapa item, dan "Poli Anak" sebelumnya punya navigasi ke `PoliDetail`).
- Semua file UI ada di folder `lib/ui/`, model di `lib/model/`.
- Dart/Flutter versi modern (memakai `super.key`).

## Struktur file akhir

```
lib/
├── model/
│   └── poli.dart
└── ui/
    ├── poli_page.dart     (DIUBAH)
    ├── poli_item.dart     (BARU)
    ├── poli_form.dart     (BARU)
    └── poli_detail.dart   (sudah ada)
```

---

## Langkah 1 – Buat `PoliItem` (pisahkan list poli)

**Latar belakang:** Jika setiap item di list ditulis manual, navigasi ke halaman Detail Poli hanya berfungsi di "Poli Anak" dan kodenya jadi panjang/tidak rapi. Solusinya: buat class `PoliItem` yang menampilkan satu data `Poli` sekaligus menangani tap untuk pindah ke `PoliDetail`.

**Buat file:** `lib/ui/poli_item.dart`

```dart
import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';

class PoliItem extends StatelessWidget {
  final Poli poli;

  const PoliItem({super.key, required this.poli});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text("${poli.namaPoli}"),
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PoliDetail(poli: poli)));
      },
    );
  }
}
```

**Penjelasan:** `GestureDetector` adalah widget untuk mendeteksi gesture pada widget lain, seperti tap, double tap, dan lain-lain. Di sini dipakai untuk mendeteksi `onTap` lalu `Navigator.push` ke `PoliDetail`.

---

## Langkah 2 – Ubah `PoliPage` agar memakai `PoliItem`

**Edit file:** `lib/ui/poli_page.dart`

Ganti isi file menjadi (versi sementara, sebelum tombol tambah):

```dart
import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';
import 'poli_item.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Poli")),
      body: ListView(
        children: [
          PoliItem(poli: Poli(namaPoli: "Poli Anak")),
          PoliItem(poli: Poli(namaPoli: "Poli Kandungan")),
          PoliItem(poli: Poli(namaPoli: "Poli Gigi")),
          PoliItem(poli: Poli(namaPoli: "Poli THT")),
        ],
      ),
    );
  }
}
```

**Hasil yang diharapkan:** Keempat poli (Anak, Kandungan, Gigi, THT) tampil sebagai kartu, dan tap pada salah satunya membuka `PoliDetail` untuk poli tersebut.

---

## Langkah 3 – Buat Form Tambah Poli

**Buat file:** `lib/ui/poli_form.dart`

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
            children: [
              TextField(
                  decoration: const InputDecoration(labelText: "Nama Poli")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text("Simpan"))
            ],
          ),
        ),
      ),
    );
  }
}
```

**Penjelasan:**
- `Form` + `GlobalKey<FormState>` menjadi dasar form di Flutter.
- Isinya satu `TextField` (label "Nama Poli"), jarak `SizedBox(height: 20)`, dan tombol `ElevatedButton` "Simpan".
- Tombol Simpan masih kosong (`onPressed: () {}`) karena logika simpan belum diminta di pertemuan ini.

---

## Langkah 4 – Buka Form dari `PoliPage` lewat AppBar

Tambahkan `actions` pada `AppBar` di `poli_page.dart`:

```dart
AppBar(
  title: const Text("Data Poli"),
  actions: [
    GestureDetector(
      child: const Icon(Icons.add),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PoliForm()));
      },
    )
  ],
)
```

**Kode final lengkap `lib/ui/poli_page.dart`** (menggantikan versi Langkah 2, jangan lupa import `poli_form.dart`):

```dart
import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';
import 'poli_item.dart';
import 'poli_form.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Poli"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PoliForm()));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          PoliItem(poli: Poli(namaPoli: "Poli Anak")),
          PoliItem(poli: Poli(namaPoli: "Poli Kandungan")),
          PoliItem(poli: Poli(namaPoli: "Poli Gigi")),
          PoliItem(poli: Poli(namaPoli: "Poli THT")),
        ],
      ),
    );
  }
}
```

---

## Checklist Verifikasi

- [ ] `flutter pub get` dan `flutter analyze` tanpa error.
- [ ] `poli_item.dart` ada di `lib/ui/` dan meng-import `../model/poli.dart` serta `poli_detail.dart`.
- [ ] `poli_page.dart` meng-import `poli_item.dart` dan `poli_form.dart`.
- [ ] Halaman "Data Poli" menampilkan 4 kartu: Poli Anak, Poli Kandungan, Poli Gigi, Poli THT.
- [ ] Tap kartu mana pun membuka `PoliDetail` yang sesuai (bukan hanya Poli Anak).
- [ ] Ikon `+` di pojok kanan atas AppBar membuka halaman "Tambah Poli".
- [ ] Halaman "Tambah Poli" menampilkan field "Nama Poli" dan tombol "Simpan".

## Catatan untuk Agent

- Ikuti kode di atas apa adanya (sesuai modul); jangan menambah state management, database, atau validasi kecuali diminta.
- Jika ada warning kecil (mis. `Key? key` di `PoliForm`, `createState` tanpa `@override`, string interpolation `"${poli.namaPoli}"` yang bisa disederhanakan), boleh dirapikan selama perilaku tidak berubah.
- Jika `Poli`, `PoliDetail`, atau `main.dart` belum ada, buat versi minimal agar proyek bisa dijalankan, dengan `PoliPage` sebagai `home`.
- Opsional (hanya jika diminta nanti): `onPressed` tombol Simpan menyimpan nama poli ke list lalu `Navigator.pop`, plus validasi `TextFormField` memakai `_formKey`.