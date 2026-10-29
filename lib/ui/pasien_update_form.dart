import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/db_service.dart';
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
        onPressed: () async {
          final pasien = Pasien(
            id: widget.pasien.id,
            nomorRm: _rmCtrl.text.trim(),
            nama: _namaCtrl.text.trim(),
            tanggalLahir: _tglCtrl.text.trim(),
            nomorTelepon: _telCtrl.text.trim(),
            alamat: _alamatCtrl.text.trim(),
          );
          if (pasien.id == null) return;
          try {
            await DbService().updatePasien(pasien);
            if (!mounted) return;
            Navigator.pop(context, true);
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Gagal update: $e")),
            );
          }
        },
        child: const Text("Simpan Perubahan"),
      );
}
