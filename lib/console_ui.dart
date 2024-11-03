import 'dart:io';

class ConsoleUI {
  void header() {
    var header = [
      "    ____  __  _______  __ __        ________  ______",
      "   / __ \\/  |/  / __ \\/ //_/ ____  /_  __/ / / /  _/",
      "  / /_/ / /|_/ / /_/ / , <  /___/   / / / /_/ // /  ",
      "  \\____/_/  /_/\\____/_/|_|         /_/  \\____/___/  "
    ];
    for (var i = 0; i < header.length; i++) {
      stdout.write(header[i]);
      stdout.write('\n');
    }
    stdout.write('\n');
  }

  void welcome() {
    stdout.write('Welcome to Omok!\n');
  }

  void promptURL(var defaultUrl) {
    stdout.write('Enter the server URL [default: $defaultUrl]\nURL: ');
  }

  void defaultURL() {
    stdout.write('Setting default URL...\n\n');
  }

  void promptStrategy(var strategies) {
    stdout.write('Select from the following Strategies (Default is 1): \n');
    if (strategies.length == 0) {
      errorMessage();
    }
    for (var i = 0; i < strategies.length; i++) {
      stdout.write('[${i + 1}] ${strategies[i]} \n');
    }
    stdout.write('Strategy: ');
  }

  void promptMove() {
    stdout.write('Enter x and y (1-15 space separated, ex: 8 10): ');
  }

  void printVar(var val) {
    stdout.write('$val\n');
  }

  void selectedStrategy(var selection) {
    stdout.write('You selected: $selection\n\n');
  }

  void errorMessage() {
    stdout.write('Error\n');
    stdout.write('\n');
  }

  void invalidInput() {
    stdout.write('Invalid Input\n');
    stdout.write('\n');
  }
}
