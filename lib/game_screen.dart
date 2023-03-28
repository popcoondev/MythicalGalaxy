import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int numPlayers;
  final List<String> playerNames;
  final GameState gameState;

  GameScreen({required this.numPlayers, required this.playerNames})
      : gameState = GameState(numPlayers);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  void _handleTap(int row, int col) {
    print('タップ: Row: $row, Col: $col');

    // 現在のプレイヤーを取得し、駒を配置
    int currentPlayer = widget.gameState.currentPlayer; // プレイヤー番号を取得するロジックを実装する
    widget.gameState.placePiece(row, col, currentPlayer);

    // ゲームの状態を更新
    setState(() {});

    // 勝利条件のチェック
    int winner = widget.gameState.checkWinner();
    if (winner != 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ゲーム終了"),
            content: Text("プレイヤー $winner の勝利です！"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // アラートを閉じる
                  Navigator.of(context).pop(); // ゲーム画面を閉じてタイトル画面に戻る
                },
              ),
            ],
          );
        },
      );
    }
    else {
      // 勝利者がいない場合、次のプレイヤーに切り替え
      widget.gameState.switchPlayer();
    }
  }

  Widget _buildPlayerInfo() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Player ${widget.gameState.currentPlayer} ${widget.playerNames[widget.gameState.currentPlayer-1]}",
            style: TextStyle(fontSize: 24),
          ),
          // ここに操作方法やターンの情報などを表示するウィジェットを追加できます
        ],
      ),
    );
  }

  Widget _buildGameBoard() {
    final cellSize = MediaQuery.of(context).size.width / 24; //ここの数値がゲームボードのサイズに影響する

    return GameBoard(
      cellSize: cellSize,
      gameState: widget.gameState,
      onTap: _handleTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mythical Galaxy"),
      ),
      body: Column(
        children: [
          _buildPlayerInfo(),
          Expanded(child: _buildGameBoard()),
        ],
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  final double cellSize;
  final GameState gameState;
  final void Function(int row, int col) onTap;

  GameBoard({required this.cellSize, required this.gameState, required this.onTap});

  @override
  _GameScreenState createState() => _GameScreenState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        // タップした位置を取得
        final x = details.localPosition.dx;
        final y = details.localPosition.dy;
        // ゲームボード上のセルの座標を計算
        final row = (y / cellSize).floor();
        final col = (x / cellSize).floor();

        onTap(row, col);
      },
      child: CustomPaint(
        painter: _GameBoardPainter(
          cellSize: cellSize,
          gameState: gameState,
        ),
        child: Container(
          width: cellSize * 9, // セルの幅と列数に基づいて幅を設定
          height: cellSize * 9, // セルの高さと行数に基づいて高さを設定
        ),
      ),
    );
  }
}

class GameState {
  List<List<int>> board;
  int currentPlayer;
  int numPlayers;

  GameState(this.numPlayers)
      : board = List.generate(9, (_) => List.filled(9, 0)),
        currentPlayer = 1;

  void placePiece(int row, int col, int player) {
    board[row][col] = player;
  }

  int checkWinner() {
    // 勝利条件をチェックするロジックを実装する
    // 勝者がいる場合はそのプレイヤー番号を返し、それ以外の場合は0を返す
    return 0;
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer % numPlayers) + 1;
  }

  int getPiece(int row, int col) {
    return board[row][col];
  }
}


class _GameBoardPainter extends CustomPainter {
  final double cellSize;
  final GameState gameState;

  _GameBoardPainter({required this.cellSize, required this.gameState});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // 円形のセルを描画
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        paint.color = Colors.grey[200]!;
        canvas.drawCircle(
          Offset(col * cellSize + cellSize / 2, row * cellSize + cellSize / 2),
          cellSize / 2 - 1,
          paint,
        );
      }
    }
    // 境界線を描画
    paint.color = Colors.black;
    paint.strokeWidth = 1;
    for (int i = 0; i <= 9; i++) {
      canvas.drawLine(Offset(0, i * cellSize), Offset(size.width, i * cellSize), paint);
      canvas.drawLine(Offset(i * cellSize, 0), Offset(i * cellSize, 9 * cellSize), paint);
    }
    // 駒を描画
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        final player = gameState.board[row][col];
        var d = DateTime.now();
        print('player: $player $d');
        if (player != 0) {
          final colors = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.orange]; // 必要なだけ色を追加
          paint.color = colors[player - 1];
          canvas.drawCircle(
            Offset(col * cellSize + cellSize / 2, row * cellSize + cellSize / 2),
            cellSize / 2 - 4,
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GameBoardPainter oldDelegate) {
    return oldDelegate.gameState != gameState;
  }
}
