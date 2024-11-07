import 'response_parser.dart';
import 'console_ui.dart';

class Board {
  var ui = ConsoleUI();
  var rp = ResponseParser();

  // var boardSize = rp.boardSize();

  int size = 15;

  int getSize(){
      return size;
  }

  var playerMoves = [[]];
  var computerMoves = [[]];

  var playerX;
  var playerY;

  var compX;
  var compY;

  void startNewPlayer(){
      playerMoves = List.generate(getSize(), (_) => List.filled(getSize(), 0));
  }

  void startNewComputer(){
    computerMoves =  List.generate(getSize(), (_) => List.filled(getSize(), 0));
  }
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
    print("${List.generate(size, (i) => (i + 1).toString().padLeft(1)).join(' ')}");
    for (int row = 1; row <= size; row++) {
      String rowNumber = row.toString().padLeft(2);

      String rowContent = List.generate(size, (col) {
        // Check if the current coordinate is taken by player 1 or player 2
        bool isPlayer = playerMoves.any((space) => space[0] == row && space[1] == col + 1);
        bool isComputer = computerMoves.any((space) => space[0] == row && space[1] == col + 1);

        if (isPlayer) return '●'; // Use '●' for player 1
        if (isComputer) return '○'; // Use '○' for player 2
        return '─'; // Use '─' for empty spaces
      }).join('┼');

      print('$rowNumber ┼$rowContent┼');
    }
  }

  void validPlayerInput() {
    if (playerMoves[playerX][playerY] == 0 &&
        computerMoves[playerX][playerY] == 0) {
      playerMoves[playerX][playerY] = 1;
    }
  }

  void printBoard() {
    playerMoves.forEach((element) {
      element.forEach(print);
    });
  }
}

void main() {
  var board = Board();
  board.startNewPlayer();
  board.startNewComputer();

  board.playerX = 10;
  board.playerY = 12;
  board.playerAdd(10,12);
  board.computerAdd(12,10);

  board.validPlayerInput();

  board.printPlayerCoords();
}
