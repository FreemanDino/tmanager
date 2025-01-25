import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  void setEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void setPassword(String newPassword) {
    _password = newPassword;
    notifyListeners();
  }

  void updateUserData(String newEmail, String newPassword) {
    _email = newEmail;
    _password = newPassword;
    notifyListeners();
  }

}
