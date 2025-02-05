import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmanager/core/routers/app_routers.dart';
import 'package:tmanager/screens/user_interface/widgets/splash_logo_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        if (mounted) {
          context.go(AppRoutes.home.path);
        }
      } else {
        if (mounted) {
          context.go(AppRoutes.verification.path);
        }
      }
    } else {
      if (mounted) {
        context.go(AppRoutes.login.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SplashLogoText(),
      ),
    );
  }
}
