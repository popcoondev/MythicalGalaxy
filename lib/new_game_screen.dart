import 'package:flutter/material.dart';

import 'game_screen.dart';

class NewGameScreen extends StatefulWidget {
  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  int _numPlayers = 1;
  List<String> _playerNames = [''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規ゲーム'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('プレイヤー人数'),
            DropdownButton<int>(
              value: _numPlayers,
              items: [for (int i = 1; i <= 5; i++) DropdownMenuItem(child: Text('$i'), value: i)],
              onChanged: (value) {
                setState(() {
                  _numPlayers = value!;
                  while (_playerNames.length < _numPlayers) {
                    _playerNames.add('');
                  }
                });
              },
            ),
            SizedBox(height: 16),
            Text('プレイヤー名'),
            for (int i = 0; i < _numPlayers; i++)
              TextField(
                onChanged: (String value) {
                  setState(() {
                    _playerNames[i] = value;
                  });
                },
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // ゲーム画面へ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      numPlayers: _numPlayers,
                      playerNames: _playerNames,
                    ),
                  ),
                );
              },
              child: Text('ゲーム開始'),
            ),
          ],
        ),
      ),
    );
  }
}
