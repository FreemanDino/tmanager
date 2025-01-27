import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmanager/core/models/user_model.dart';

class UserService {
  static final UserService instance = UserService._internal();

  factory UserService() => instance;

  UserService._internal();

  SharedPreferences? _prefs;

  Future<SharedPreferences?> _initPrefs() async {
    if (_prefs == null) return _prefs = await SharedPreferences.getInstance();

    return _prefs;
  }

  Future<void> saveLogin(String email, String password) async {
    final prefs = await _initPrefs();
    await prefs?.setString('user_email', email);
    await prefs?.setString('user_password', password);
  }

  Future<UserModel> loadLogin() async {
    final prefs = await _initPrefs();
    return UserModel(
      email: prefs?.getString('user_email'),
      password: prefs?.getString('user_password'),
    );
  }

  Future<void> verifyUser() async {
    final prefs = await _initPrefs();
    await prefs?.setBool('isVerified', true);
  }

  Future<void> isLogged() async {}
}
