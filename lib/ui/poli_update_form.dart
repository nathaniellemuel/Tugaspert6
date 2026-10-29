import 'package:flutter/material.dart';
import '../model/poli.dart';
import '../service/db_service.dart';

class PoliUpdateForm extends StatefulWidget {
  final Poli poli;

  const PoliUpdateForm({Key? key, required this.poli}) : super(key: key);

  @override
  State<PoliUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PoliUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _namaPoliCtrl.text = widget.poli.namaPoli;
  }

  @override
  void dispose() {
    _namaPoliCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Poli")),
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
                if (nama.isEmpty || widget.poli.id == null) return;
                setState(() => _saving = true);
                try {
                  await DbService().updatePoli(widget.poli.id!, nama);
                  if (!mounted) return;
                  Navigator.pop(context, true);
                } catch (e) {
                  if (!mounted) return;
                  setState(() => _saving = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal update: $e")),
                  );
                }
              },
        child: Text(_saving ? "Menyimpan..." : "Simpan Perubahan"));
  }
}
