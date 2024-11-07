import 'dart:convert';

import 'console_ui.dart';

class ResponseParser {
  var ui = ConsoleUI();
  var responseInfo;

  var responseStrategies = [];

  // int responseBoardSize;

  int responseBoardSize = 15;

  void setResponseInfo(var responseBody) {
    this.responseInfo = json.decode(responseBody);
    setStrategies();
    setBoardSize();
  }

  void setStrategies() {
    try {
      this.responseStrategies = responseInfo['strategies'];
    } catch (e) {
      ui.errorMessage();
      ui.printVar(e);
    }
  }

  void setBoardSize() {
    try {
      this.responseBoardSize = responseInfo['size'] as int;
    } catch (e) {
      ui.errorMessage();
      ui.printVar(e);
    }
  }

  String info() {
    return this.responseInfo.toString();
  }

  List strategies() {
    return this.responseStrategies;
  }

  int boardSize() {
    return this.responseBoardSize;
  }
}
