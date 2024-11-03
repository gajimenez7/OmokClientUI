import 'dart:convert';

import 'console_ui.dart';

class ResponseParser {
  var ui = ConsoleUI();
  var responseInfo;

  var responseStrategies = [];

  void setResponseInfo(var responseBody) {
    this.responseInfo = json.decode(responseBody);
    setStrategies();
  }

  void setStrategies() {
    try {
      this.responseStrategies = responseInfo['strategies'];
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
}
