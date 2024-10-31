class WebClient{
  var theDefaultUrl = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/info';
  var theResponse;
  var theResponseBody;

  bool isValid(var url){
    return !(url == null || url.isEmpty);
  }

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
