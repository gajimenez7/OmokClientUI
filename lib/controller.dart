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

    while (!validInputFlag) {
      validInputFlag = strategyInput();
    }

    validInputFlag = false;

    while (!validInputFlag) {
      validInputFlag = movementInput();
    }

    validInputFlag = false;
  }

  Future<bool> urlInput() async {
    // user input for url or set default url if empty input
    String? url;

    ui.promptURL(client.defaultServer());

    url = stdin.readLineSync();
    url = (!client.isValid(url)) ? client.defaultServer() : url;

    if (client.isValid(url)) ui.defaultURL();

    try {
      var response = await http.get(Uri.parse(url!));

      if (response.statusCode == 200) {
        client.setResponse(response);

        rp.setResponseInfo(client.responseBody());
            } else {
        ui.errorMessage();
        ui.printVar('Invalid URL: ${response.statusCode}\n');
        return false;
      }
    } catch (e) {
      ui.errorMessage();
      ui.printVar('Exception: $e \n');
      return false;
    }
    return true;
  }

  bool strategyInput() {
    String? line;
    // user input for strategies or smart (1) if empty

    ui.promptStrategy(rp.strategies());

    line = stdin.readLineSync();
    line = (line == null || line.isEmpty) ? '1' : line;
    try {
      var selection = int.parse(line);
      if (selection == 0 || selection > rp.strategies().length) {
        ui.invalidInput();
        return false;
      } else {
        ui.selectedStrategy(rp.strategies()[selection - 1]);
      }
    } on FormatException {
      ui.invalidInput();
      return false;
    }
    return true;
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
        var mvSelect1 = int.parse(inputs[0]);
        var mvSelect2 = int.parse(inputs[1]);

        board.playerX = mvSelect1;
        board.playerY = mvSelect2;
      } on FormatException {
        ui.invalidInput();
        return false;
      } on RangeError {
        ui.invalidInput();
        return false;
      }
    }
    return true;
  }
}
