import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:tmanager/core/models/user_model.dart';

class UserService {
  static final UserService instance = UserService._internal();
  factory UserService() => instance;
  UserService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Logger _logger = Logger();

  Future<void> saveLogin(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i('User registered successfully: $email');
    } catch (e) {
      _logger.e('Error during registration: $e');
    }
  }

  Future<UserModel> loadLogin() async {
    final user = _auth.currentUser;
    return UserModel(
      email: user?.email,
      password: null,
    );
  }

  Future<void> verifyUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        _logger.i('Verification email sent to ${user.email}');
      } catch (e) {
        _logger.e('Error sending verification email: $e');
      }
    } else {
      _logger.w('User is already verified or no user is logged in.');
    }
  }

  Future<bool> isLogged() async {
    final user = _auth.currentUser;
    return user != null;
  }
}
