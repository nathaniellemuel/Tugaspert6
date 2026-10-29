import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/db_service.dart';
import 'pegawai_item.dart';
import 'pegawai_form.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  late Future<List<Pegawai>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _future = DbService().getPegawaiList();
  }

  Future<void> _refresh() async {
    setState(_load);
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pegawai"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final changed = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PegawaiForm()),
              );
              if (changed == true && mounted) _refresh();
            },
          )
        ],
      ),
      body: FutureBuilder<List<Pegawai>>(
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
            return const Center(child: Text("Belum ada data pegawai"));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              children: [for (final p in list) PegawaiItem(pegawai: p)],
            ),
          );
        },
      ),
    );
  }
}
