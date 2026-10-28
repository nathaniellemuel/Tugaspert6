import 'package:flutter/material.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({super.key});

  @override
  State<PasienForm> createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const TextField(decoration: InputDecoration(labelText: "Nomor RM")),
              const TextField(decoration: InputDecoration(labelText: "Nama")),
              const TextField(decoration: InputDecoration(labelText: "Tanggal Lahir")),
              const TextField(decoration: InputDecoration(labelText: "Nomor Telepon")),
              const TextField(decoration: InputDecoration(labelText: "Alamat")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Simpan"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
