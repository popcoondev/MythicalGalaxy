import 'dart:math';

class GameBoard {
  List<List<int>> planetConnections;

  GameBoard() : planetConnections = List.generate(9, (_) => []);

  void generateConnections() {
    final random = Random();

    for (int i = 0; i < 9; i++) {
      for (int j = i + 1; j < 9; j++) {
        if (random.nextDouble() < 0.3) {
          planetConnections[i].add(j);
          planetConnections[j].add(i);
        }
      }
    }
  }

  bool isValidMove(int fromRow, int fromCol, int toRow, int toCol) {
    int fromIndex = fromRow * 3 + fromCol;
    int toIndex = toRow * 3 + toCol;

    return planetConnections[fromIndex].contains(toIndex);
  }

}
