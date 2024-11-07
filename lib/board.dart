import 'dart:io';
import 'response_parser.dart';
import 'console_ui.dart';

class Board {
  var ui = ConsoleUI();
  var rp = ResponseParser();

  var boardSize = rp.boardSize();

  var playerCoords = List.generate(boardSize, (_) => List.filled(boardSize, 0));

  var compCoords = List.generate(boardSize, (_) => List.filled(boardSize, 0));

  var playerX;
  var playerY;

  var compX;
  var compY;

  void printPlayerCoords() {
    for (var i = 0; i < playerCoords.length; i++) {
      for (var j = 0; j < playerCoords[i].length; j++) {
        stdout.write('${playerCoords[i][j]} ');
      }
      stdout.write('\n');
    }
    print('\n');
  }

  void validPlayerInput() {
    if (playerCoords[playerX][playerY] == 0 &&
        compCoords[playerX][playerY] == 0) {
      ui.printVar('${playerCoords[playerX][playerY]}\n');
      playerCoords[playerX][playerY] = 1;
    }
  }

  void printBoard() {
    playerCoords.forEach((element) {
      element.forEach(print);
    });
  }
}

void main() {
  var board = Board();

  board.printBoard();
}
