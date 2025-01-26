import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/screens/main_app/my_app.dart';
import 'core/provider/main_navigation_provider.dart';
import 'core/provider/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()..init()),
        ChangeNotifierProvider(create: (context) => MainNavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
