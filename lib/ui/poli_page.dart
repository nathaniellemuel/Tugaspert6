import 'package:flutter/material.dart';
import '../model/poli.dart';
import '../service/db_service.dart';
import 'poli_item.dart';
import 'poli_form.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  late Future<List<Poli>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _future = DbService().getPoliList();
  }

  Future<void> _refresh() async {
    setState(_load);
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Poli"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final changed = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PoliForm()),
              );
              if (changed == true && mounted) _refresh();
            },
          )
        ],
      ),
      body: FutureBuilder<List<Poli>>(
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
            return const Center(child: Text("Belum ada data poli"));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              children: [for (final p in list) PoliItem(poli: p)],
            ),
          );
        },
      ),
    );
  }
}
