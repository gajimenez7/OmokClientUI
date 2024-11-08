import 'dart:convert';

import 'console_ui.dart';

class ResponseParser {
  var ui = ConsoleUI();

  var responseInfo;

  var responseStrategies = [];

  String selectedStrategy = '';

  int responseBoardSize = 0;

  String pid = '';

  bool isWin = false;

  bool isDraw = false;

  // int responseBoardSize = 15;

  void setResponseInfo(var responseBody) {
    this.responseInfo = json.decode(responseBody);
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

  void setPID(){
    try {
      pid = responseInfo['pid'];
    } catch (e) {
      ui.errorMessage();
      ui.printVar(e);
    }
  }

  void setWin(){
    try {
      pid = responseInfo['pid'];
    } catch (e) {
      ui.errorMessage();
      ui.printVar(e);
    }
  }

  void startGame(){

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
