import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_provider.dart';
import 'nft_model.dart';

class AddScreen extends StatelessWidget {
  final TextEditingController _artController = TextEditingController();
  final TextEditingController _pathController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  void _submit(BuildContext context) async {
    String art = _artController.text;
    String path = _pathController.text;
    String nama = _namaController.text;
    String keterangan = _keteranganController.text;

    if (art.isNotEmpty &&
        path.isNotEmpty &&
        nama.isNotEmpty &&
        keterangan.isNotEmpty) {
      var response = await http.post(
        Uri.parse('http://192.168.43.14/nft/nft.php'),
        body: {
          'art': art,
          'path': path,
          'nama': nama,
          'keterangan': keterangan,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to save data'),
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
        title: Text('Add NFT'),
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
