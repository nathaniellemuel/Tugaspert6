import 'package:flutter/material.dart';
import '../model/poli.dart';
import '../service/db_service.dart';
import 'poli_detail.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({super.key});

  @override
  State<PoliForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _namaPoliCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Poli")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [_fieldNamaPoli(), const SizedBox(height: 20), _tombolSimpan()],
          ),
        ),
      ),
    );
  }

  _fieldNamaPoli() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: _namaPoliCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: _saving
            ? null
            : () async {
                final nama = _namaPoliCtrl.text.trim();
                if (nama.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Nama Poli wajib diisi")),
                  );
                  return;
                }
                setState(() => _saving = true);
                try {
                  final id = await DbService().insertPoli(nama);
                  if (!mounted) return;
                  Navigator.pop(context, true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PoliDetail(
                        poli: Poli(id: id, namaPoli: nama),
                      ),
                    ),
                  );
                } catch (e) {
                  if (!mounted) return;
                  setState(() => _saving = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal simpan: $e")),
                  );
                }
              },
        child: Text(_saving ? "Menyimpan..." : "Simpan"));
  }
}
