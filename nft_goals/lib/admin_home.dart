import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:nft_goals/edit.dart';
import 'package:nft_goals/add.dart';
import 'dart:convert';
import 'user_provider.dart';
import 'nft_model.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<NFTModel> _nftList = [];

  @override
  void initState() {
    super.initState();
    _fetchNFTData();
  }

  void _fetchNFTData() async {
    var response =
        await http.get(Uri.parse('http://192.168.43.14/nft/nft.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _nftList = data
            .map((item) => NFTModel(
                  id: item['id'],
                  art: item['art'],
                  path: item['path'],
                  nama: item['nama'],
                  keterangan: item['keterangan'],
                ))
            .toList();
      });
    }
  }

  void _deleteNFT(int id) async {
    var response =
        await http.delete(Uri.parse('http://192.168.43.14/nft/nft.php?id=$id'));
    if (response.statusCode == 200) {
      _fetchNFTData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: ListView.builder(
        itemCount: _nftList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(_nftList[index].path),
            title: Text(_nftList[index].nama),
            subtitle: Text(_nftList[index].keterangan),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteNFT(_nftList[index].id),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(nft: _nftList[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
