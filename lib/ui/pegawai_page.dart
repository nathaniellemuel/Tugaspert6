import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import 'pegawai_item.dart';
import 'pegawai_form.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pegawai"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PegawaiForm()),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: [
          PegawaiItem(
            pegawai: Pegawai(
              nip: "197001011990031001",
              nama: "Budi Santoso",
              tanggalLahir: "1970-01-01",
              nomorTelepon: "081234567890",
              email: "budi@klinik.com",
              password: "budi123",
            ),
          ),
          PegawaiItem(
            pegawai: Pegawai(
              nip: "198505122010012002",
              nama: "Siti Aminah",
              tanggalLahir: "1985-05-12",
              nomorTelepon: "081298765432",
              email: "siti@klinik.com",
              password: "siti123",
            ),
          ),
          PegawaiItem(
            pegawai: Pegawai(
              nip: "199011232015031003",
              nama: "Andi Pratama",
              tanggalLahir: "1990-11-23",
              nomorTelepon: "081211223344",
              email: "andi@klinik.com",
              password: "andi123",
            ),
          ),
        ],
      ),
    );
  }
}
