import 'package:flutter/material.dart';
import 'poli_page.dart';
import 'pegawai_page.dart';
import 'pasien_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Klinik App")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.local_hospital),
            title: const Text("Data Poli"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PoliPage()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Data Pegawai"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PegawaiPage()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Data Pasien"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PasienPage()),
            ),
          ),
        ],
      ),
    );
  }
}
