import 'dart:convert';

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
