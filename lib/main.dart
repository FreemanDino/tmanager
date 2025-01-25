import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/main_app/my_app.dart';
import 'provider/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider()..init(),
      child: const MyApp(),
    ),
  );
}
