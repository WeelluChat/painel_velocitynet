import 'dart:ui';

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
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      title: 'Flutter Demo',
      home: const MyTabbedPanel(),
    );
  }
}
