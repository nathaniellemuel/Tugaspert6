import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  @override
  Widget build(BuildContext context) {
    List<Poli> daftarPoli = [
      Poli(namaPoli: "Poli Anak"),
      Poli(namaPoli: "Poli Kandungan"),
      Poli(namaPoli: "Poli Gigi"),
      Poli(namaPoli: "Poli THT"),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Data Poli")),
      body: ListView(
        children: daftarPoli.map((poli) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoliDetail(poli: poli),
                ),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(poli.namaPoli),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
