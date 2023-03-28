import 'package:flutter/material.dart';

import 'new_game_screen.dart';

class TitleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mythical Galaxy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // 新規ゲーム画面へ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewGameScreen()),
                );
              },
              child: Text('新規ゲーム'),
            ),
            ElevatedButton(
              onPressed: () {
                // 続きからプレイ画面へ遷移
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoadGameScreen()),
                // );
              },
              child: Text('続きからプレイ'),
            ),
            ElevatedButton(
              onPressed: () {
                // 設定画面へ遷移
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                // );
              },
              child: Text('設定'),
            ),
            ElevatedButton(
              onPressed: () {
                // ヘルプ画面へ遷移
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HelpScreen()),
                // );
              },
              child: Text('ヘルプ'),
            ),
          ],
        ),
      ),
    );
  }
}
