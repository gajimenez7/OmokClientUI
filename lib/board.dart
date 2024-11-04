import 'dart:io';
import 'console_ui.dart';

class Board {
  var ui = ConsoleUI();

  var playerCoords = List.generate(15, (_) => List.filled(15, 0));

  var compCoords = List.generate(15, (_) => List.filled(15, 0));

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
}

void main() {
  var ui = ConsoleUI();
  var board = Board();

  board.printPlayerCoords();

  board.playerX = 10;
  board.playerY = 12;

  board.validPlayerInput();

  board.printPlayerCoords();
}
