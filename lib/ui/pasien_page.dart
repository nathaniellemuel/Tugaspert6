import 'package:flutter/material.dart';
import '../model/pasien.dart';
import 'pasien_item.dart';
import 'pasien_form.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({super.key});

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pasien"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PasienForm()),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: [
          PasienItem(
            pasien: Pasien(
              nomorRm: "RM-001",
              nama: "Joko Susilo",
              tanggalLahir: "1980-03-15",
              nomorTelepon: "081234567890",
              alamat: "Jl. Merdeka No. 10, Jakarta",
            ),
          ),
          PasienItem(
            pasien: Pasien(
              nomorRm: "RM-002",
              nama: "Dewi Lestari",
              tanggalLahir: "1992-07-22",
              nomorTelepon: "081298765432",
              alamat: "Jl. Sudirman No. 25, Bandung",
            ),
          ),
          PasienItem(
            pasien: Pasien(
              nomorRm: "RM-003",
              nama: "Rudi Hartono",
              tanggalLahir: "1975-11-08",
              nomorTelepon: "081211223344",
              alamat: "Jl. Gatot Subroto No. 5, Semarang",
            ),
          ),
        ],
      ),
    );
  }
}
