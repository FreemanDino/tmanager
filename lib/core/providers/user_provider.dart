import 'package:flutter/material.dart';
import 'package:tmanager/core/models/user_model.dart';
import 'package:tmanager/core/service/user_service.dart';

class UserProvider with ChangeNotifier {
  final _userService = UserService.instance;
  UserModel? _user;

  // Getter for the current user
  UserModel? get user => _user;

  // Getter to check if the user is logged in
  bool get isLogged => _user != null;

  // Getter to retrieve the userId from the UserModel
  String? get userId => _user?.uid; // Assuming UserModel has an 'id' field

  // Initialize the user provider by loading the logged-in user
  Future<void> init() async {
    _user = await _userService.loadLogin();
    notifyListeners();
  }

  // Register a new user
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

  // Log in an existing user
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

  // Log out the current user
  Future<void> logout() async {
    await _userService.signOut();
    _user = null;
    notifyListeners();
  }

  // Send email verification to the current user
  Future<void> sendEmailVerification() async {
    await _userService.sendEmailVerification();
    notifyListeners();
  }
}
