import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_provider.dart';
import 'nft_model.dart';

class EditScreen extends StatefulWidget {
  final NFTModel nft;

  EditScreen({required this.nft});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _artController;
  late TextEditingController _pathController;
  late TextEditingController _namaController;
  late TextEditingController _keteranganController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai dari data NFT yang ada
    _artController = TextEditingController(text: widget.nft.art);
    _pathController = TextEditingController(text: widget.nft.path);
    _namaController = TextEditingController(text: widget.nft.nama);
    _keteranganController = TextEditingController(text: widget.nft.keterangan);
  }

  void _submit(BuildContext context) async {
    String art = _artController.text;
    String path = _pathController.text;
    String nama = _namaController.text;
    String keterangan = _keteranganController.text;

    if (art.isNotEmpty &&
        path.isNotEmpty &&
        nama.isNotEmpty &&
        keterangan.isNotEmpty) {
      // Kirim data ke API nft.php untuk di-update di MySQL berdasarkan ID
      var response = await http.put(
        Uri.parse('http://192.168.43.14/nft/nft.php?id=${widget.nft.id}'),
        body: {
          'art': art,
          'path': path,
          'nama': nama,
          'keterangan': keterangan,
        },
      );

      if (response.statusCode == 200) {
        // Jika data berhasil di-update, kembali ke halaman AdminHomeScreen
        Navigator.pop(context);
      } else {
        // Jika terjadi kesalahan, tampilkan pesan error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update data'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit NFT'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _artController,
              decoration: InputDecoration(labelText: 'Art'),
            ),
            TextField(
              controller: _pathController,
              decoration: InputDecoration(labelText: 'Path'),
            ),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _keteranganController,
              decoration: InputDecoration(labelText: 'Keterangan'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _submit(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
