import 'console_ui.dart';
import 'web_client.dart';
import 'response_parser.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

// create Controller class with start method
class Controller {
  var client = WebClient();
  var ui = ConsoleUI();
  var rp = ResponseParser();

  void start() async{
    ui.header();
    ui.welcome();

    ui.promptURL(client.defaultServer());

    await urlInput();

    strategyInput();

    movementInput();
  }

  Future<void> urlInput() async {
    String? url;

    // user input for url or set default url if empty input
    url = stdin.readLineSync();
    url = (!client.isValid(url)) ? client.defaultServer() : url;

    if (client.isValid(url)) ui.defaultURL();

    try {
      var response = await http.get(Uri.parse(url!));

      if (response.statusCode == 200) {
        client.setResponse(response);

        if (client.responseBody() != null) {
          rp.setResponseInfo(client.responseBody());
        } else {
          ui.printVar('response body is null');
          ui.errorMessage();
        }
      } else {
        ui.errorMessage();
        ui.printVar('Invalid URL: ${response.statusCode}');
      }
    } catch (e) {
      ui.errorMessage();
      ui.printVar('Exception: $e');
    }
  }

  void strategyInput() {
    String? line;
    // user input for strategies or smart (1) if empty

    ui.promptStrategy(rp.strategies());

    line = stdin.readLineSync();
    line = (line == null || line.isEmpty) ? '1' : line;
    try {
      var selection = int.parse(line);
      if (selection == 0 || selection > rp.strategies().length) {
        ui.invalidInput();
      } else {
        ui.selectedStrategy(rp.strategies()[selection - 1]);
      }
    } on FormatException {
      ui.invalidInput();
    }
  }

  void movementInput() {
    String? line;

    // user input for player movement
    ui.promptMove();
    line = stdin.readLineSync();

    if (line == null) {
      ui.invalidInput();
    } else {
      List<String> inputs = line.split(" ");
      try {
        var mvSelection1 = int.parse(inputs[0]);
        var mvSelection2 = int.parse(inputs[1]);
        ui.printVar(mvSelection1);
        ui.printVar(mvSelection2);
      } on FormatException {
        ui.invalidInput();
      } on RangeError {
        ui.invalidInput();
      }
    }
  }
}
