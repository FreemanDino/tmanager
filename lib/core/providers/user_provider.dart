import 'package:flutter/material.dart';
import 'package:tmanager/core/models/user_model.dart';
import 'package:tmanager/core/service/user_service.dart';

class UserProvider with ChangeNotifier {
  final _userService = UserService.instance;

  UserModel _user = UserModel();

  UserModel get user => _user;

  bool get isLogged => _user.email != null && _user.password != null;

  Future<void> init() async {
    _user = await _userService.loadLogin();
    notifyListeners();
  }

  void saveLogin({required String email, required String password}) {
    _userService.saveLogin(email, password);
    init();
  }
}
