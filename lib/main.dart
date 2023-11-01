import 'dart:ui';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:painel_velocitynet/pages/home.dart';
import 'package:painel_velocitynet/pages/login.dart';

void main() async {
   String? authToken = html.window.localStorage['authToken'];

  Widget initialScreen = (authToken != null) ? const MyTabbedPanel() : const Login();
   runApp(MaterialApp(
    scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
    home: initialScreen,
  ));
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
      // theme: ThemeData(
      //   useMaterial3: true,
      // ),
      home: const Login(),
    );
  }
}
