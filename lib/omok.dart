import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() async{
  var client = WebClient();

  var ui = ConsoleUI();
  ui.welcome();

  ui.promptURL(client.defaultServer());

  String? url = stdin.readLineSync();
  if(url == null || url.isEmpty){
    url = client.defaultServer();
    ui.defaultURL();
  }

  client.setResponse(await http.get(Uri.parse(url)));

  var rp = ResponseParser();
  rp.setInfo(client.responseBody());

  ui.promptStrategy(rp.strategies());

  String? line = stdin.readLineSync();
  if(line == null || line.isEmpty){
    line = '1';
  }
  try{
    var selection = int.parse(line);
    if(selection == 0 || selection > rp.strategies().length){
    ui.invalidInput();
    }else{
      ui.selectedStrategy(rp.strategies()[selection-1]);
    }
  } on FormatException{
      ui.errorMessage();
  }
}

class WebClient{
  var theDefaultUrl = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/info';
  var theResponse;
  var theResponseBody;
  
  void setResponse(var response){
    this.theResponse = response;
    setResponseBody();
  }

  void setResponseBody(){
    this.theResponseBody = this.theResponse.body;
  }

  String defaultServer(){
    return theDefaultUrl;
  }

  String response(){
    return this.theResponse;
  }

  String responseBody(){
    return this.theResponseBody;
  }

}

class ResponseParser{
  var responseInfo;

  var responseStrategies;

  void setInfo(var responseBody){
    this.responseInfo = json.decode(responseBody);
    setStrategies();
  }

  void setStrategies(){
    this.responseStrategies = responseInfo['strategies'];
  }

  String info(){
    return this.responseInfo;
  }

  List strategies(){
    return this.responseStrategies;
  }
}

class ConsoleUI{
  void welcome(){
    stdout.write('Welcome to Omok!\n');
  }

  void promptURL(var defaultUrl){
    stdout.write('Enter the server URL [default: $defaultUrl]\n');
  }

  void defaultURL(){
    print('Setting default URL...\n');
  }

  void promptStrategy(var strategies){
    print('Select from the following Strategies (Default is 1): \n');
    for (var i = 0; i < strategies.length; i++) {
      print('[${i+1}] ${strategies[i]} ');
    }
  }

  void selectedStrategy(var selection){
    print('You selected: $selection');
  }

  void errorMessage(){
    print('Error');
  }

  void invalidInput(){
    print('Invalid Input');
  }
}
