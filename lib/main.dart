import 'dart:ui';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:painel_velocitynet/modules/config/config_provider/config_provider.dart';
import 'package:painel_velocitynet/modules/panel/panel.dart';
import 'package:painel_velocitynet/pages/login.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String? authToken = html.window.localStorage['authToken'];

    Widget initialScreen = (authToken != null) ? const Panel() : const Login();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConfigProvider>(
          create: (context) => ConfigProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Painel - Velocitynet",
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        home: initialScreen,
      ),
    );
  }
}
