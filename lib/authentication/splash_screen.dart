import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmanager/authentication/first_login_screen.dart';
import 'package:tmanager/main_app/main_page.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isVerified = prefs.getBool('isVerified') ?? false;

    if (!mounted) return;

    if (isVerified) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstLoginScreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RichText(
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
      ),
    );
  }
}
