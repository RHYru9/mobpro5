// File: ui/poli_page.dart
// Versi FIXED - Tanpa warning sort_child_properties_last

import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';
import 'poli_form.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  // List untuk menyimpan data poli
  List<Poli> listPoli = [
    Poli(id: "1", namaPoli: "Poli Anak"),
    Poli(id: "2", namaPoli: "Poli Kandungan"),
    Poli(id: "3", namaPoli: "Poli Gigi"),
    Poli(id: "4", namaPoli: "Poli THT"),
  ];

  void _navigateToDetail(Poli poli, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PoliDetail(poli: poli)),
    );

    // Handle result dari detail page
    if (result != null) {
      setState(() {
        if (result == 'hapus') {
          // Hapus data dari list
          listPoli.removeAt(index);
        } else if (result is Poli) {
          // Update data di list
          listPoli[index] = result;
        }
      });
    }
  }

  void _tambahPoli() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PoliForm()),
    );

    // Jika ada data baru, tambahkan ke list
    if (result != null && result is Poli) {
      setState(() {
        // Generate ID sederhana
        result.id = (listPoli.length + 1).toString();
        listPoli.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Poli"),
        actions: [
          IconButton(
            onPressed: _tambahPoli,
            icon: const Icon(Icons.add),
            tooltip: "Tambah Poli",
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listPoli.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToDetail(listPoli[index], index),
            child: Card(
              child: ListTile(
                title: Text(listPoli[index].namaPoli),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahPoli,
        tooltip: "Tambah Poli",
        child: const Icon(Icons.add), // child dipindah ke paling akhir ya
      ),
    );
  }
}
