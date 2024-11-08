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

    // game loop

    validInputFlag = false;

    while(!validInputFlag) {
      validInputFlag = await startGame();
    }

    validInputFlag = false;

    while (!validInputFlag) {
      validInputFlag = movementInput();
    }

    validInputFlag = false;

    while (!validInputFlag) {
      validInputFlag = await nextMove();
    }
    ui.printVar(rp.responseInfo);

    ui.printBoard(board.getSize(), board.playerX, board.playerY);

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

  Future<bool> startGame() async{
    if (await client.getURL('${client.gameUrl(rp.selectedStrategy)}', rp)) {
      rp.setPID();
      return true;
    }
    return false;
  }

  Future <bool> nextMove() async{
    if (await client.getURL('${client.playUrl(rp.pid, board.playerY.toString(), board.playerY.toString())}', rp)) {
      return true;
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

        board.startNewPlayer();
        board.startNewComputer();

        board.playerX = mvSelect1;
        board.playerY = mvSelect2;

        board.validPlayerInput();

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
