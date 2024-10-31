import 'ConsoleUI.dart';
import 'WebClient.dart';
import 'ResponseParser.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

// create Controller class with start method

void main() async{
  var client = WebClient();

  var ui = ConsoleUI();
  ui.header();
  ui.welcome();

  ui.promptURL(client.defaultServer());

  String? url = stdin.readLineSync();
  url = (!client.isValid(url)) ? client.defaultServer() : url;
  if(client.isValid(url))
    ui.defaultURL();

  client.setResponse(await http.get(Uri.parse(url!)));

  var rp = ResponseParser();
  rp.setInfo(client.responseBody());

  ui.promptStrategy(rp.strategies());

  String? line = stdin.readLineSync();
  line = (line==null||line.isEmpty) ? '1' : line;
  //if(line == null || line.isEmpty){
  //  line = '1';
  //}
  try{
    var selection = int.parse(line);
    if(selection == 0 || selection > rp.strategies().length){
    ui.invalidInput();
    }else{
      ui.selectedStrategy(rp.strategies()[selection-1]);
    }
  } on FormatException{
      ui.invalidInput();
  }

  ui.promptMove();
  line = stdin.readLineSync();

  if(line == null){
    ui.invalidInput();
  }else{
    List<String> inputs = line.split(" ");
    try{
      var mvSelection1 = int.parse(inputs[0]);
      var mvSelection2 = int.parse(inputs[1]);
      ui.printVar(mvSelection1);
      ui.printVar(mvSelection2);
    } on FormatException{
      ui.invalidInput();
    } on RangeError{
      ui.invalidInput();
    }
  }
}
