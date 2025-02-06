import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmanager/core/routers/app_routers.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  bool _isEmailVerified = false;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _resendVerificationEmail();

    // Start a timer to periodically check if the email is verified
    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await _checkEmailVerificationStatus();
    });
  }

  Future<void> _checkEmailVerificationStatus() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Reload the user's data to get the latest emailVerified status
      await user.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        setState(() {
          _isEmailVerified = true;
        });

        // Stop the timer since the email is verified
        _timer.cancel();

        // Redirect to the home screen
        if (mounted) {
          context.go(AppRoutes.home.path);
        }
      }
    }
  }

  Future<void> _resendVerificationEmail() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Письмо с подтверждением отправлено на вашу почту'),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка отправки письма: $e')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Пользователь не найден или уже подтвержден'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (mounted) {
                    context.go(AppRoutes.register.path);
                  }
                },
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'T',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: 'Manager',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Мы отправили письмо с подтверждением на вашу электронную почту. Пожалуйста, проверьте вашу почту и подтвердите адрес.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: _resendVerificationEmail,
                child: const Text(
                  'Отправить письмо',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              if (_isEmailVerified)
                const Center(
                  child: Text(
                    'Ваша электронная почта подтверждена! Перенаправление...',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
