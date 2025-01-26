import 'package:flutter/material.dart';

class SplashLogoText extends StatelessWidget {
  const SplashLogoText({
    super.key,
  });

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
