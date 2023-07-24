import 'package:flutter/foundation.dart';
import 'package:nft_goals/user_model.dart';

class UserProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  void login(int userId) {
    _user = UserModel(userId);
    notifyListeners();
  }
}
