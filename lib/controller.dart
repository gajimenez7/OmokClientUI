import 'console_ui.dart';
import 'web_client.dart';
import 'response_parser.dart';
import 'board.dart';

import 'package:http/http.dart' as http;
import 'dart:io';

// create Controller class with start method
class Controller {
  var client = WebClient();
  var ui = ConsoleUI();
  var rp = ResponseParser();
  var board = Board();

  bool validInputFlag = false;

  void start() async {
    ui.header();
    ui.welcome();

    while (!validInputFlag) {
      validInputFlag = await urlInput();
    }

    validInputFlag = false;

    rp.setBoardSize();

    board.setSize(rp.boardSize());

    // start new game

    while (!validInputFlag) {
      validInputFlag = strategyInput();
    }

    validInputFlag = false;

    while (!validInputFlag) {
      validInputFlag = await startGame();
    }

    board.startNewPlayer();
    board.startNewComputer();

    // game loop
    while (!rp.gameEnd()) {
      validInputFlag = false;

      while (!validInputFlag) {
        ui.playerSymbols();
        validInputFlag = movementInput();
      }

      validInputFlag = false;

      while (!validInputFlag) {
        validInputFlag = await nextMove();
      }

      ui.printBoard(board.getSize(), board);
    }

    if (rp.playerWin) {
      ui.playerWon(rp.playerRow);
    } else if (rp.computerWin) {
      ui.computerWon(rp.computerRow);
    } else {
      ui.gameDraw();
    }
  }

  Future<bool> urlInput() {
    // user input for url or set default url if empty input
    String? url;

    ui.promptURL(client.defaultServer());

    url = stdin.readLineSync();
    url = (!client.isValid(url)) ? client.defaultServer() : url;

    if (client.isValid(url)) ui.defaultURL();

    return client.getURL(url, rp);
  }

  bool strategyInput() {
    String? line;
    rp.setStrategies();
    // user input for strategies or smart (1) if empty
    ui.promptStrategy(rp.responseStrategies);

    line = stdin.readLineSync();
    line = (line == null || line.isEmpty) ? '1' : line;
    try {
      var selection = int.parse(line);

      if (selection == 0 || selection > rp.strategies().length) {
        ui.invalidInput();
        return false;
      } else {
        rp.selectedStrategy = rp.strategies()[selection - 1];
        ui.selectedStrategy(rp.selectedStrategy);
      }
    } on FormatException {
      ui.invalidInput();
      return false;
    }
    return true;
  }

  Future<bool> startGame() async {
    if (await client.getURL('${client.gameUrl(rp.selectedStrategy)}', rp)) {
      rp.setPID();
      return true;
    }
    return false;
  }

  Future<bool> nextMove() async {
    try {
      if (await client.getURL(
          '${client.playUrl(rp.pid, (board.playerX-1).toString(), (board.playerY-1).toString())}',
          rp)) {
        // player moves

        rp.playerWin = rp.responseInfo['ack_move']['isWin'];
        rp.playerRow = rp.responseInfo['ack_move']['row'];

        // check that player hasn't won
        if (rp.playerWin) {
          return true;
        }

        rp.isDraw = rp.responseInfo['ack_move']['isDraw'];

        // computer moves
        board.computerX = rp.responseInfo['move']['x'] + 1;
        board.computerY = rp.responseInfo['move']['y'] + 1;

        board.addComputerMove();

        rp.computerWin = rp.responseInfo['move']['isWin'];
        rp.computerRow = rp.responseInfo['move']['row'];

        // print computer selection:
        ui.computerMoves(board.computerX, board.computerY);

        return true;
      }
    } catch (e) {
      ui.printVar(e);
      ui.invalidInput();
      return false;
    }
    return false;
  }

  bool movementInput() {
    String? line;

    // user input for player movement
    ui.promptMove();
    line = stdin.readLineSync();

    if (line == null) {
      ui.invalidInput();
      return false;
    } else {
      List<String> inputs = line.split(" ");
      try {
        int mvSelect1 = int.parse(inputs[0]);
        int mvSelect2 = int.parse(inputs[1]);

        board.playerX = mvSelect1;
        board.playerY = mvSelect2;

        ui.printVar('');

        return board.validPlayerInput();
      } on FormatException {
        ui.invalidInput();
        ui.printVar('Format Exception');
        return false;
      } on RangeError {
        ui.invalidInput();
        ui.printVar('Range Error');
        return false;
      }
    }
    return true;
  }
}
