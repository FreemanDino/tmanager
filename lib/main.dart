import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/main_app/edit_task_page.dart';
import 'package:tmanager/authentication/first_login_screen.dart';
import 'package:tmanager/main_app/main_page.dart';
import 'package:tmanager/main_app/main_page_screen.dart';
import 'package:tmanager/main_app/my_app.dart';
import 'package:tmanager/authentication/registration_screen.dart';
import 'package:tmanager/authentication/splash_screen.dart';
import 'package:tmanager/user_state.dart';
import 'package:tmanager/authentication/verification_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserState(),
      child: MyApp(),
    ),
  );
}
