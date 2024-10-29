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
