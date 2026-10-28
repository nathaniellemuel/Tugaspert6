import 'package:flutter/material.dart';
import '../model/pegawai.dart';
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
        onPressed: () {
          Pegawai pegawai = Pegawai(
            id: 0,
            nip: _nipCtrl.text,
            nama: _namaCtrl.text,
            tanggalLahir: _tglCtrl.text,
            nomorTelepon: _telCtrl.text,
            email: _emailCtrl.text,
            password: _pwdCtrl.text,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => PegawaiDetail(pegawai: pegawai)),
          );
        },
        child: const Text("Simpan"),
      );
}
