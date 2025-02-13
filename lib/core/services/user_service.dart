import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:tmanager/core/models/user_model.dart';

class UserService {
  static final UserService instance = UserService._internal();
  factory UserService() => instance;
  UserService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  Future<UserModel?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i('User registered successfully: ${credential.user?.email}');
      return UserModel.fromFirebase(credential.user);
    } catch (e) {
      _logger.e('Error during registration: $e');
      return null;
    }
  }

  Future<UserModel?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i('User logged in successfully: ${credential.user?.email}');
      return UserModel.fromFirebase(credential.user);
    } catch (e) {
      _logger.e('Error during login: $e');
      return null;
    }
  }

  Future<UserModel?> loadLogin() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebase(user);
    }
    return null;
  }

  Future<bool> isLogged() async {
    return _auth.currentUser != null;
  }

  Future<void> sendEmailVerification() async {
    final User? user = _auth.currentUser;
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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _logger.i('User signed out successfully.');
    } catch (e) {
      _logger.e('Error during sign out: $e');
    }
  }
}
