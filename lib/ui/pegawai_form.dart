import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/db_service.dart';
import 'pegawai_detail.dart';

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({super.key});

  @override
  State<PegawaiForm> createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _nipCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tglCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nipCtrl.dispose();
    _namaCtrl.dispose();
    _tglCtrl.dispose();
    _telCtrl.dispose();
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pegawai")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNip(),
              const SizedBox(height: 20),
              _fieldNama(),
              const SizedBox(height: 20),
              _fieldTanggalLahir(),
              const SizedBox(height: 20),
              _fieldNomorTelepon(),
              const SizedBox(height: 20),
              _fieldEmail(),
              const SizedBox(height: 20),
              _fieldPassword(),
              const SizedBox(height: 20),
              _tombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  _fieldNip() => TextField(
        decoration: const InputDecoration(labelText: "NIP"),
        controller: _nipCtrl,
      );

  _fieldNama() => TextField(
        decoration: const InputDecoration(labelText: "Nama"),
        controller: _namaCtrl,
      );

  _fieldTanggalLahir() => TextField(
        decoration: const InputDecoration(labelText: "Tanggal Lahir"),
        controller: _tglCtrl,
      );

  _fieldNomorTelepon() => TextField(
        decoration: const InputDecoration(labelText: "Nomor Telepon"),
        controller: _telCtrl,
      );

  _fieldEmail() => TextField(
        decoration: const InputDecoration(labelText: "Email"),
        controller: _emailCtrl,
      );

  _fieldPassword() => TextField(
        decoration: const InputDecoration(labelText: "Password"),
        obscureText: true,
        controller: _pwdCtrl,
      );

  _tombolSimpan() => ElevatedButton(
        onPressed: _saving
            ? null
            : () async {
                if (_nipCtrl.text.trim().isEmpty ||
                    _namaCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("NIP dan Nama wajib diisi")),
                  );
                  return;
                }
                setState(() => _saving = true);
                try {
                  final pegawai = Pegawai(
                    nip: _nipCtrl.text.trim(),
                    nama: _namaCtrl.text.trim(),
                    tanggalLahir: _tglCtrl.text.trim(),
                    nomorTelepon: _telCtrl.text.trim(),
                    email: _emailCtrl.text.trim(),
                    password: _pwdCtrl.text,
                  );
                  final id = await DbService().insertPegawai(pegawai);
                  if (!mounted) return;
                  Navigator.pop(context, true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (c) => PegawaiDetail(
                              pegawai: Pegawai(
                                id: id,
                                nip: pegawai.nip,
                                nama: pegawai.nama,
                                tanggalLahir: pegawai.tanggalLahir,
                                nomorTelepon: pegawai.nomorTelepon,
                                email: pegawai.email,
                                password: pegawai.password,
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
