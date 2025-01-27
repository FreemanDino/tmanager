import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserProvider p) => p.user);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]{6,30}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    emailController.text = user.email ?? '';
    passwordController.text = user.password ?? '';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[800],
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Электронная почта: ${user.email ?? ''}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xFF141414),
                        title: const Text(
                          'Изменить данные',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Новая эл. почта',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста, введите почту';
                                  }
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Неверный формат электронной почты';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Новый пароль',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста, введите пароль';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                controller: confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Подтвердить пароль',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                                  border: const OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(WidgetState.hovered) ||
                                    states.contains(WidgetState.pressed)) {
                                  return Colors.grey;
                                }
                                return Colors.transparent;
                              }),
                            ),
                            child: const Text(
                              'Отмена',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  confirmPasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Пожалуйста, заполните все поля',
                                    ),
                                  ),
                                );
                                return;
                              }
                              if (!emailRegex.hasMatch(emailController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Неверный формат электронной почты',
                                    ),
                                  ),
                                );
                                return;
                              }
                              if (passwordController.text.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Пароль должен содержать минимум 6 символов',
                                    ),
                                  ),
                                );
                                return;
                              }
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Пароли не совпадают'),
                                  ),
                                );
                              } else if (formKey.currentState?.validate() ??
                                  false) {
                                context.read<UserProvider>().saveLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                Navigator.pop(context);
                              }
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(WidgetState.hovered) ||
                                    states.contains(WidgetState.pressed)) {
                                  return Colors.grey;
                                }
                                return Colors.transparent;
                              }),
                            ),
                            child: const Text(
                              'Сохранить',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Изменить данные',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
