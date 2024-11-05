import 'dart:io';
import 'console_ui.dart';

class Board {
  var ui = ConsoleUI();

  var playerCoords = List.generate(15, (_) => List.filled(15, 0));
  final int size = 15;
  var compCoords = List.generate(15, (_) => List.filled(15, 0));
  List<List<int>> playerMoves = [];
  List<List<int>> computerMoves = [];
  var playerX;
  var playerY;

  var compX;
  var compY;
  void playerAdd(int row, int column) {
    playerMoves.add([row, column]);
  }
  void computerAdd(int row, int column) {
    computerMoves.add([row, column]);
  }
  void printPlayerCoords() {
    // for (var i = 0; i < playerCoords.length; i++) {
    //   for (var j = 0; j < playerCoords[i].length; j++) {
    //     stdout.write('${playerCoords[i][j]} ');
    //   }
    //   stdout.write('\n');
    // }
    // print('\n');
    // got to fix this it shows funny :V
    print("   ${List.generate(size, (i) => (i + 1).toString().padLeft(2)).join(' ')}");
    for (int row = 1; row <= size; row++) {
      String rowNumber = row.toString().padLeft(2);

      String rowContent = List.generate(size, (col) {
        // Check if the current coordinate is taken by player 1 or player 2
        bool isPlayer1 = playerMoves.any((space) => space[0] == row && space[1] == col + 1);
        bool isPlayer2 = computerMoves.any((space) => space[0] == row && space[1] == col + 1);

        if (isPlayer1) return '●'; // Use '●' for player 1
        if (isPlayer2) return '○'; // Use '○' for player 2
        return '─'; // Use '─' for empty spaces
      }).join('┼');

      print('$rowNumber ┼$rowContent┼');
    }
  }

  void validPlayerInput() {
    if (playerCoords[playerX][playerY] == 0 &&
        compCoords[playerX][playerY] == 0) {
      ui.printVar('${playerCoords[playerX][playerY]}\n');
      playerCoords[playerX][playerY] = 1;
    }
  }
}

void main() {
  var ui = ConsoleUI();
  var board = Board();

  board.printPlayerCoords();

  board.playerX = 10;
  board.playerY = 12;
  board.playerAdd(10,12);
  board.computerAdd(12,10);

  board.validPlayerInput();

  board.printPlayerCoords();
}
