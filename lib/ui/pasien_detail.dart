import 'package:flutter/material.dart';
import '../model/pasien.dart';
import 'pasien_update_form.dart';

class PasienDetail extends StatefulWidget {
  final Pasien pasien;

  const PasienDetail({super.key, required this.pasien});

  @override
  State<PasienDetail> createState() => _PasienDetailState();
}

class _PasienDetailState extends State<PasienDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pasien")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("No. RM : ${widget.pasien.nomorRm}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Nama : ${widget.pasien.nama}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Tanggal Lahir : ${widget.pasien.tanggalLahir}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Nomor Telepon : ${widget.pasien.nomorTelepon}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Alamat : ${widget.pasien.alamat}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_tombolUbah(), _tombolHapus()],
            ),
          ],
        ),
      ),
    );
  }

  _tombolUbah() => ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => PasienUpdateForm(pasien: widget.pasien)),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text("Ubah"),
      );

  _tombolHapus() => ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"),
      );
}
