import 'package:flutter/material.dart';
import '../model/pasien.dart';
import '../service/db_service.dart';
import 'pasien_item.dart';
import 'pasien_form.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({super.key});

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  late Future<List<Pasien>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _future = DbService().getPasienList();
  }

  Future<void> _refresh() async {
    setState(_load);
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pasien"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final changed = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PasienForm()),
              );
              if (changed == true && mounted) _refresh();
            },
          )
        ],
      ),
      body: FutureBuilder<List<Pasien>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Gagal konek ke MySQL.\nPastikan container klinik-mysql jalan."),
                    const SizedBox(height: 8),
                    Text("${snapshot.error}",
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _refresh,
                      child: const Text("Coba lagi"),
                    ),
                  ],
                ),
              ),
            );
          }
          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return const Center(child: Text("Belum ada data pasien"));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              children: [for (final p in list) PasienItem(pasien: p)],
            ),
          );
        },
      ),
    );
  }
}
