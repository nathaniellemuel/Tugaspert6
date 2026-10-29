import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/db_service.dart';
import 'pegawai_detail.dart';

class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);

  @override
  State<PegawaiUpdateForm> createState() => _PegawaiUpdateFormState();
}

class _PegawaiUpdateFormState extends State<PegawaiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nipCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tglCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nipCtrl.text = widget.pegawai.nip;
    _namaCtrl.text = widget.pegawai.nama;
    _tglCtrl.text = widget.pegawai.tanggalLahir;
    _telCtrl.text = widget.pegawai.nomorTelepon;
    _emailCtrl.text = widget.pegawai.email;
    _pwdCtrl.text = widget.pegawai.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pegawai")),
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

  _fieldNip() => TextField(decoration: const InputDecoration(labelText: "NIP"), controller: _nipCtrl);
  _fieldNama() => TextField(decoration: const InputDecoration(labelText: "Nama"), controller: _namaCtrl);
  _fieldTanggalLahir() => TextField(decoration: const InputDecoration(labelText: "Tanggal Lahir"), controller: _tglCtrl);
  _fieldNomorTelepon() => TextField(decoration: const InputDecoration(labelText: "Nomor Telepon"), controller: _telCtrl);
  _fieldEmail() => TextField(decoration: const InputDecoration(labelText: "Email"), controller: _emailCtrl);
  _fieldPassword() => TextField(decoration: const InputDecoration(labelText: "Password"), obscureText: true, controller: _pwdCtrl);

  _tombolSimpan() => ElevatedButton(
        onPressed: () async {
          final pegawai = Pegawai(
            id: widget.pegawai.id,
            nip: _nipCtrl.text.trim(),
            nama: _namaCtrl.text.trim(),
            tanggalLahir: _tglCtrl.text.trim(),
            nomorTelepon: _telCtrl.text.trim(),
            email: _emailCtrl.text.trim(),
            password: _pwdCtrl.text,
          );
          if (pegawai.id == null) return;
          try {
            await DbService().updatePegawai(pegawai);
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
