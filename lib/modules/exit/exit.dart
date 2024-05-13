import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:painel_velocitynet/modules/entity/menu_entity.dart';
import 'dart:html' as html;

import 'package:painel_velocitynet/pages/login.dart';

class Exit extends StatefulWidget {
  static const route = 'Sair';
  final MenuEntity menu;
  const Exit({super.key, required this.menu});

  @override
  State<Exit> createState() => _ExitState();
}

class _ExitState extends State<Exit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff292929),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                html.window.localStorage.remove('authToken');
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Login(),
                ));
              },
              child: const Text(
                'Sair da Conta',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
