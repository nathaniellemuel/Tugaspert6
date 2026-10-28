import 'package:flutter/material.dart';
import '../model/pasien.dart';
import 'pasien_detail.dart';

class PasienUpdateForm extends StatefulWidget {
  final Pasien pasien;

  const PasienUpdateForm({Key? key, required this.pasien}) : super(key: key);

  @override
  State<PasienUpdateForm> createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<PasienUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _rmCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tglCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _rmCtrl.text = widget.pasien.nomorRm;
    _namaCtrl.text = widget.pasien.nama;
    _tglCtrl.text = widget.pasien.tanggalLahir;
    _telCtrl.text = widget.pasien.nomorTelepon;
    _alamatCtrl.text = widget.pasien.alamat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pasien")),
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
            id: widget.pasien.id ?? 0,
            nomorRm: _rmCtrl.text,
            nama: _namaCtrl.text,
            tanggalLahir: _tglCtrl.text,
            nomorTelepon: _telCtrl.text,
            alamat: _alamatCtrl.text,
          );
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => PasienDetail(pasien: pasien)),
          );
        },
        child: const Text("Simpan Perubahan"),
      );
}
