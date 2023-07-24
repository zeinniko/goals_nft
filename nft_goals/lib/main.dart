import 'package:flutter/material.dart';
import 'package:nft_goals/admin_home.dart';
import 'package:nft_goals/home.dart';
import 'package:nft_goals/user_provider.dart';
import 'package:provider/provider.dart';

import 'login.dart';

void main() {
  runApp(
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goals NFT',
      home: AdminHomeScreen(),
    );
  }
}
