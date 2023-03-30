import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final GameState gameState;
  final List<String> playerNames;

  GameScreen({required this.playerNames})
      : gameState = GameState(numberOfPlayers: playerNames.length);

  @override
  _GameScreenState createState() => _GameScreenState(gameState: gameState, playerNames: playerNames);
}

class _GameScreenState extends State<GameScreen> {
  GameState gameState;
  List<String> playerNames;
  double cellSize = 0;

  _GameScreenState({required this.gameState, required this.playerNames});

  void _handleTap(int row, int col) {
    print('タップ: Row: $row, Col: $col');

    // 現在のプレイヤーを取得し、駒を配置
    int currentPlayer = gameState.currentPlayer;
    gameState.placePiece(row, col, currentPlayer);

    // 状態が変更されたため、ウィジェットを更新
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double minDimension = (screenWidth < screenHeight) ? screenWidth : screenHeight;
    double boardSize = minDimension * 0.8;
    double cellSize = boardSize / 9;

    return Scaffold(
      appBar: AppBar(
        title: Text('神話の銀河'),
      ),
      body: Column(
        children: [
          _buildPlayerInfo(),
          Expanded(
            child: Center(
              child: SizedBox(
                width: boardSize,
                height: boardSize,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: Size(boardSize, boardSize),
                          painter: _GameBoardPainter(gameState: gameState, cellSize: cellSize),
                        ),
                        Positioned.fill(
                          child: GestureDetector(
                            onTapDown: (details) {
                              RenderBox box = context.findRenderObject()! as RenderBox;
                              Offset localPosition = box.globalToLocal(details.globalPosition);
                              int row = (localPosition.dy / cellSize).floor();
                              int col = (localPosition.dx / cellSize).floor();
                              _handleTap(row, col);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPlayerInfo() {
    String playerName;
    if (gameState.currentPlayer <= playerNames.length) {
      playerName = playerNames[gameState.currentPlayer - 1];
    } else {
      playerName = 'Unknown';
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Player ${gameState.currentPlayer} $playerName",
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}



class GameBoardWidget extends StatelessWidget {
  final double cellSize;
  final GameState gameState;
  final void Function(int row, int col) onTap;

  GameBoardWidget({
    required this.cellSize,
    required this.gameState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        RenderBox box = context.findRenderObject()! as RenderBox;
        Offset localPosition = box.globalToLocal(details.globalPosition);
        int row = (localPosition.dy / cellSize).floor();
        int col = (localPosition.dx / cellSize).floor();
        onTap(row, col);
      },
      child: CustomPaint(
        painter: _GameBoardPainter(gameState: gameState, cellSize: cellSize),
      ),
    );
  }
}

class GameState {
  List<List<int>> board;
  int currentPlayer;
  bool gameOver;
  int numberOfPlayers;

  GameState({required this.numberOfPlayers})
      : board = List.generate(9, (_) => List.filled(9, 0)),
        currentPlayer = 1,
        gameOver = false;

  void placePiece(int row, int col, int player) {
    if (board[row][col] == 0 && !gameOver) {
      board[row][col] = player;
      _checkForGameOver(row, col, player);
      _switchPlayer();
    }
  }

  void _checkForGameOver(int row, int col, int player) {
    // 勝敗判定ロジックを実装します。必要に応じて gameOver を true に設定します。
  }

  void _switchPlayer() {
    currentPlayer = (currentPlayer % numberOfPlayers) + 1;
  }
}


class _GameBoardPainter extends CustomPainter {
  final GameState gameState;
  final double cellSize;

  _GameBoardPainter({required this.gameState, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    print('_GameBoardPainter paint');
    final paint = Paint();

    // 背景を描画
    paint.color = Colors.grey[200]!;
    canvas.drawRect(Offset.zero & size, paint);

    // マス目を描画
    paint.color = Colors.black;
    paint.strokeWidth = 1.0;
    for (int i = 0; i <= 9; ++i) {
      canvas.drawLine(Offset(0, i * cellSize), Offset(size.width, i * cellSize), paint);
      canvas.drawLine(Offset(i * cellSize, 0), Offset(i * cellSize, size.height), paint);
    }

    // 神話の経路を描画
    paint.color = Colors.red;
    paint.strokeWidth = 2.0;

    // 駒を描画
    for (int row = 0; row < 9; ++row) {
      for (int col = 0; col < 9; ++col) {
        final player = gameState.board[row][col];
        if (player != 0) {
          // プレイヤーごとの色を定義
          final colors = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.purple];

          final paint = Paint()..color = colors[player - 1];
          final circleCenter = Offset((col + 0.5) * cellSize, (row + 0.5) * cellSize);
          canvas.drawCircle(circleCenter, cellSize * 0.3, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GameBoardPainter oldDelegate) {
    return oldDelegate.gameState != gameState;
  }
}
