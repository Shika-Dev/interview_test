import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<dynamic> keluhan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getKeluhan();
  }

  Future<void> getKeluhan() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/keluhan'));
      if (response.statusCode == 200) {
        setState(() {
          keluhan = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Keluhan'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: keluhan.length,
              itemBuilder: (context, index) {
                final item = keluhan[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item['judul'] ?? 'Tidak ada judul'),
                    subtitle: Text(item['deskripsi'] ?? 'Tidak ada deskripsi'),
                    trailing: Text(item['status'] ?? 'Status tidak diketahui'),
                  ),
                );
              },
            ),
    );
  }
}
