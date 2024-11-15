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

  var computerX;
  var computerY;

  void startNewPlayer() {
    playerMoves = List.generate(getSize(), (_) => List.filled(getSize(), 0));
  }

  void startNewComputer() {
    computerMoves = List.generate(getSize(), (_) => List.filled(getSize(), 0));
  }

  void setSize(int s) {
    this.size = s;
  }

  int getSize() {
    return size;
  }

  bool validPlayerInput() {
    if (playerMoves[playerX][playerY] == 0 &&
        computerMoves[playerX][playerY] != 1) {
      playerMoves[playerX][playerY] = 1;

      return true;
    }
    return false;
  }

  void addComputerMove() {
    computerMoves[computerX][computerY] = 1;
  }
}
