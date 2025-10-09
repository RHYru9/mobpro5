// File: ui/poli_detail.dart

import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_form.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;

  const PoliDetail({super.key, required this.poli});

  @override
  State<PoliDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  void _ubah() async {
    // Navigasi ke form edit
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PoliForm(poli: widget.poli)),
    );

    // FIXED: Cek apakah widget masih mounted sebelum menggunakan context
    if (!mounted) return;

    // Jika ada hasil dari form, kembali ke halaman list dengan data baru
    if (result != null) {
      Navigator.pop(context, result);
    }
  }

  void _hapus() {
    // Tampilkan dialog konfirmasi
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: Text(
          "Apakah Anda yakin ingin menghapus ${widget.poli.namaPoli}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              // Kembali ke halaman list dengan status hapus
              Navigator.pop(context); // Tutup dialog
              Navigator.pop(context, 'hapus'); // Kembali ke list
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

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
              ElevatedButton(
                onPressed: _ubah,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Ubah"),
              ),
              ElevatedButton(
                onPressed: _hapus,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Hapus"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
