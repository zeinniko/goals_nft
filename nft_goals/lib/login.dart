import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import 'user_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _penggunaController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();

  void _login(BuildContext context) async {
    String pengguna = _penggunaController.text.trim();
    String token = _tokenController.text.trim();

    if (pengguna.isNotEmpty && token.isNotEmpty) {
      var response = await http.post(
        Uri.parse('http://192.168.43.14/nft/login.php'),
        body: {
          'pengguna': pengguna,
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('error')) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Login Failed'),
              content: Text(data['error']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          int userId = data['user_id'];
          Provider.of<UserProvider>(context, listen: false).login(userId);

          if (userId == 1) {
            Navigator.pushNamed(context, '/admin_home');
          } else {
            Navigator.pushNamed(context, '/home');
          }
        }
      } else {
        // Jika response gagal, tampilkan pesan error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to connect to server'),
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
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _penggunaController,
              decoration: InputDecoration(labelText: 'pengguna'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(labelText: 'token'),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
