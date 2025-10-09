//poli_form.dart
import 'package:flutter/material.dart';
import '../model/poli.dart';

class PoliForm extends StatefulWidget {
  final Poli? poli; // Optional, untuk mode edit

  const PoliForm({super.key, this.poli});

  @override
  State<PoliForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Jika mode edit, isi field dengan data yang ada
    if (widget.poli != null) {
      _namaPoliController.text = widget.poli!.namaPoli;
    }
  }

  @override
  void dispose() {
    _namaPoliController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      // Buat object Poli baru
      Poli poli = Poli(id: widget.poli?.id, namaPoli: _namaPoliController.text);

      // Kembali ke halaman sebelumnya dengan membawa data
      Navigator.pop(context, poli);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poli == null ? "Tambah Poli" : "Ubah Poli"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaPoliController,
                decoration: const InputDecoration(
                  labelText: "Nama Poli",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Poli tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  widget.poli == null ? "Simpan" : "Update",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
