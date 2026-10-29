import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/db_service.dart';
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
  bool _saving = false;

  @override
  void dispose() {
    _rmCtrl.dispose();
    _namaCtrl.dispose();
    _tglCtrl.dispose();
    _telCtrl.dispose();
    _alamatCtrl.dispose();
    super.dispose();
  }

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
        onPressed: _saving
            ? null
            : () async {
                if (_rmCtrl.text.trim().isEmpty ||
                    _namaCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Nomor RM dan Nama wajib diisi")),
                  );
                  return;
                }
                setState(() => _saving = true);
                try {
                  final pasien = Pasien(
                    nomorRm: _rmCtrl.text.trim(),
                    nama: _namaCtrl.text.trim(),
                    tanggalLahir: _tglCtrl.text.trim(),
                    nomorTelepon: _telCtrl.text.trim(),
                    alamat: _alamatCtrl.text.trim(),
                  );
                  final id = await DbService().insertPasien(pasien);
                  if (!mounted) return;
                  Navigator.pop(context, true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (c) => PasienDetail(
                              pasien: Pasien(
                                id: id,
                                nomorRm: pasien.nomorRm,
                                nama: pasien.nama,
                                tanggalLahir: pasien.tanggalLahir,
                                nomorTelepon: pasien.nomorTelepon,
                                alamat: pasien.alamat,
                              ),
                            )),
                  );
                } catch (e) {
                  if (!mounted) return;
                  setState(() => _saving = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal simpan: $e")),
                  );
                }
              },
        child: Text(_saving ? "Menyimpan..." : "Simpan"),
      );
}
