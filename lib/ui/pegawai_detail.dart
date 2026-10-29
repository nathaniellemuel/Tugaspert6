import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/db_service.dart';
import 'pegawai_update_form.dart';

class PegawaiDetail extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiDetail({super.key, required this.pegawai});

  @override
  State<PegawaiDetail> createState() => _PegawaiDetailState();
}

class _PegawaiDetailState extends State<PegawaiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pegawai")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("NIP : ${widget.pegawai.nip}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Nama : ${widget.pegawai.nama}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Tanggal Lahir : ${widget.pegawai.tanggalLahir}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Nomor Telepon : ${widget.pegawai.nomorTelepon}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Email : ${widget.pegawai.email}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Password : ••••••••", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_tombolUbah(), _tombolHapus()],
            ),
          ],
        ),
      ),
    );
  }

  _tombolUbah() => ElevatedButton(
        onPressed: () async {
          final changed = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) =>
                    PegawaiUpdateForm(pegawai: widget.pegawai)),
          );
          if (changed == true && mounted) Navigator.pop(context, true);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text("Ubah"),
      );

  _tombolHapus() => ElevatedButton(
        onPressed: () async {
          final ok = await showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: const Text("Hapus Pegawai?"),
              content: Text("Hapus ${widget.pegawai.nama}?"),
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
          if (widget.pegawai.id == null) {
            Navigator.pop(context, true);
            return;
          }
          try {
            await DbService().deletePegawai(widget.pegawai.id!);
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
        child: const Text("Hapus"),
      );
}
