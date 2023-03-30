import 'package:flutter/material.dart';
import 'package:mythicalgalaxy/game_screen.dart';
import 'package:mythicalgalaxy/main_menu.dart';

import 'new_game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameState gameState = GameState(numberOfPlayers: 0); // ゲームの初期状態を作成
    return MaterialApp(
      title: '神話の銀河',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainMenu(),
        '/new_game': (context) => NewGameScreen(), // 追加
      },
    );
  }
}
