import 'console_ui.dart';
import 'response_parser.dart';

import 'package:http/http.dart' as http;

class WebClient {
  var ui = ConsoleUI();

  var theDefaultUrl = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/info';
  var newGameUrl = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/new/';
  var playGameUrl = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/play/';
  var theResponse;
  var theResponseBody;
  var pid;

  String gameUrl(String strategy) {
    return '${newGameUrl}?strategy=${strategy}';
  }

  String playUrl(String pid, String x, String y) {
    return '${playGameUrl}?pid=${pid}&x=$x&y=$y';
  }

  Future<bool> getURL(var url, ResponseParser rp) async {
    try {
      var response = await http.get(Uri.parse(url!));

      if (response.statusCode == 200) {
        setResponse(response);

        rp.setResponseInfo(theResponseBody);
      } else {
        ui.errorMessage();
        ui.printVar('Invalid URL: ${response.statusCode}\n');
        return false;
      }
    } catch (e) {
      ui.errorMessage();
      ui.printVar('Exception: $e \n');
      return false;
    }
    return true;
  }

  bool isValid(var url) {
    return url != null && url.isNotEmpty;
  }

  void setResponse(var response) {
    this.theResponse = response;
    setResponseBody();
  }

  void setResponseBody() {
    this.theResponseBody = this.theResponse?.body;
  }

  String defaultServer() {
    return theDefaultUrl;
  }

  String response() {
    return this.theResponse;
  }

  String responseBody() {
    return this.theResponseBody;
  }
}
