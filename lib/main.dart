import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/core/providers/task_provider.dart';
import 'package:tmanager/screens/main_app/my_app.dart';
import 'core/providers/navigation_provider.dart';
import 'core/providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()..init()),
        ChangeNotifierProvider(create: (context) => MainNavigationProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
