import 'package:flutter/material.dart';
import 'poli_update_form.dart';
import '../model/poli.dart';
import '../service/db_service.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;

  const PoliDetail({super.key, required this.poli});

  @override
  State<PoliDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Poli")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Nama Poli : ${widget.poli.namaPoli}",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _tombolUbah(),
              _tombolHapus(),
            ],
          )
        ],
      ),
    );
  }

  _tombolUbah() {
    return ElevatedButton(
        onPressed: () async {
          final changed = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PoliUpdateForm(poli: widget.poli)));
          if (changed == true && mounted) Navigator.pop(context, true);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text("Ubah"));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () async {
          final ok = await showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: const Text("Hapus Poli?"),
              content: Text("Hapus ${widget.poli.namaPoli}?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(c, false),
                    child: const Text("Batal")),
                TextButton(
                    onPressed: () => Navigator.pop(c, true),
                    child: const Text("Hapus")),
              ],
            ),
          );
          if (ok != true || !mounted) return;
          if (widget.poli.id == null) {
            Navigator.pop(context, true);
            return;
          }
          try {
            await DbService().deletePoli(widget.poli.id!);
            if (!mounted) return;
            Navigator.pop(context, true);
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Gagal hapus: $e")),
            );
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }
}
