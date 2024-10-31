import 'dart:io';

class ConsoleUI{
  void welcome(){
    stdout.write('Welcome to Omok!\n');
  }

  void promptURL(var defaultUrl){
    stdout.write('Enter the server URL [default: $defaultUrl]\nURL: ');
  }

  void defaultURL(){
    print('Setting default URL...\n');
  }

  void promptStrategy(var strategies){
    stdout.write('Select from the following Strategies (Default is 1): \n');
    for (var i = 0; i < strategies.length; i++) {
      print('[${i+1}] ${strategies[i]} ');
    }
    stdout.write('Strategy: ');
  }

  void promptMove(){
    stdout.write('Enter x and y (1-15 space separated, ex: 8 10): ');
  }

  void printVar(var val){
      stdout.write('$val\n');
  }

  void selectedStrategy(var selection){
    print('You selected: $selection\n');
  }

  void errorMessage(){
    print('Error');
  }

  void invalidInput(){
    print('Invalid Input');
  }
}
