import 'package:flutter/material.dart';
import '../model/pasien.dart';
import 'pasien_detail.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({super.key});

  @override
  State<PasienForm> createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final _rmCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tglCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNomorRm(),
              const SizedBox(height: 20),
              _fieldNama(),
              const SizedBox(height: 20),
              _fieldTanggalLahir(),
              const SizedBox(height: 20),
              _fieldNomorTelepon(),
              const SizedBox(height: 20),
              _fieldAlamat(),
              const SizedBox(height: 20),
              _tombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  _fieldNomorRm() => TextField(decoration: const InputDecoration(labelText: "Nomor RM"), controller: _rmCtrl);
  _fieldNama() => TextField(decoration: const InputDecoration(labelText: "Nama"), controller: _namaCtrl);
  _fieldTanggalLahir() => TextField(decoration: const InputDecoration(labelText: "Tanggal Lahir"), controller: _tglCtrl);
  _fieldNomorTelepon() => TextField(decoration: const InputDecoration(labelText: "Nomor Telepon"), controller: _telCtrl);
  _fieldAlamat() => TextField(decoration: const InputDecoration(labelText: "Alamat"), controller: _alamatCtrl);

  _tombolSimpan() => ElevatedButton(
        onPressed: () {
          Pasien pasien = Pasien(
            id: 0,
            nomorRm: _rmCtrl.text,
            nama: _namaCtrl.text,
            tanggalLahir: _tglCtrl.text,
            nomorTelepon: _telCtrl.text,
            alamat: _alamatCtrl.text,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => PasienDetail(pasien: pasien)),
          );
        },
        child: const Text("Simpan"),
      );
}
