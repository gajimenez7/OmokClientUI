import 'response_parser.dart';
import 'console_ui.dart';
import 'dart:io';

class Board {
  var ui = ConsoleUI();
  var rp = ResponseParser();

  int size = 0;

  List<List<int>> playerMoves = [];
  List<List<int>> computerMoves = [];

  var playerX;
  var playerY;

  var compX;
  var compY;

  void startNewPlayer() {
    playerMoves = List.generate(getSize(), (_) => List.filled(getSize(), 0));
  }

  void startNewComputer() {
    computerMoves = List.generate(getSize(), (_) => List.filled(getSize(), 0));
  }

  void playerAdd(int row, int column) {
    playerMoves.add([row, column]);
  }

  void computerAdd(int row, int column) {
    computerMoves.add([row, column]);
  }

  void setSize(int s) {
    this.size = s;
  }

  int getSize() {
    return size;
  }

  void validPlayerInput() {
    if (playerMoves[playerX][playerY] == 0 &&
        computerMoves[playerX][playerY] == 0) {
      playerMoves[playerX][playerY] = 1;
    }
  }
}
