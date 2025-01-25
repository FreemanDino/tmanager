import 'package:flutter/material.dart';

class MainLogoText extends StatelessWidget {
  const MainLogoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'T',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          TextSpan(
            text: 'Manager',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
