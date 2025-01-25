import 'package:flutter/material.dart';
import 'package:tmanager/main_app/main_page.dart';
import 'package:tmanager/service/user_service.dart';

import 'registration_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});
  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  final _codeController = TextEditingController();
  final _generatedCode = '123456';
  Future<void> _verifyCode() async {
    if (_codeController.text == _generatedCode) {
      await UserService.instance.verifyUser();
      if (mounted) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Неверный код')),
      );
    }
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                  );
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
              TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'Введите код из письма',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Подтвердить',
                  style: TextStyle(
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
