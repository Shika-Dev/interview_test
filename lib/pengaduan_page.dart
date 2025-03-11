import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class PengaduanPage extends StatefulWidget {
  @override
  _PengaduanPageState createState() => _PengaduanPageState();
}

class _PengaduanPageState extends State<PengaduanPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controller untuk form fields
  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  
  File? buktiFile;
  String? fileName;

  Future<void> _pilihBukti() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      setState(() {
        buktiFile = File(result.files.single.path!);
        fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pengaduan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nikController,
                decoration: InputDecoration(labelText: 'NIK'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: noHpController,
                decoration: InputDecoration(labelText: 'No. HP'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No. HP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: judulController,
                decoration: InputDecoration(labelText: 'Judul Pengaduan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi Permasalahan'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pilihBukti,
                icon: Icon(Icons.upload_file),
                label: Text('Upload Bukti (Foto/PDF)'),
              ),
              if (fileName != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('File terpilih: $fileName'),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && buktiFile != null) {
                    // Implementasi pengiriman data ke admin
                    // TODO: Tambahkan logika untuk mengirim data ke backend
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pengaduan berhasil dikirim')),
                    );
                  } else if (buktiFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Harap upload bukti pengaduan')),
                    );
                  }
                },
                child: Text('Kirim Pengaduan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
