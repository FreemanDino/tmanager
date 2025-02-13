import 'package:flutter/material.dart';
import 'package:tmanager/core/models/user_model.dart';
import 'package:tmanager/core/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final _userService = UserService.instance;
  UserModel? _user;

  UserModel? get user => _user;

  bool get isLogged => _user != null;

  String? get userId => _user?.uid;

  Future<void> init() async {
    _user = await _userService.loadLogin();
    notifyListeners();
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    final UserModel? newUser = await _userService.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (newUser != null) {
      _user = newUser;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final UserModel? loggedInUser =
        await _userService.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (loggedInUser != null) {
      _user = loggedInUser;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _userService.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    await _userService.sendEmailVerification();
    notifyListeners();
  }
}
