// File: ui/poli_detail.dart
// Dengan fungsi Ubah dan Hapus yang berfungsi

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
  // Fungsi untuk tombol Ubah
  void _ubah() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PoliForm()),
    );
  }

  // Fungsi untuk tombol Hapus
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
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
            },
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              Navigator.pop(context); // Kembali ke halaman list

              // Tampilkan notifikasi berhasil dihapus
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${widget.poli.namaPoli} berhasil dihapus"),
                  backgroundColor: Colors.red,
                ),
              );
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
                onPressed: _ubah, // ← Panggil fungsi _ubah
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Ubah"),
              ),
              ElevatedButton(
                onPressed: _hapus, // ← Panggil fungsi _hapus
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
