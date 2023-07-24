import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome, User ${user.userId}'),
      ),
    );
  }
}