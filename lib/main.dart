import 'package:flutter/material.dart';
import 'package:painel_velocitynet/pages/home.dart';
import 'package:painel_velocitynet/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
