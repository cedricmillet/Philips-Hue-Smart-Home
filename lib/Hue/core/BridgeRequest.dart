import 'package:http/http.dart' as http;

class BridgeRequest {
  
  int timeoutInSeconds = 2;


  /**
   * Send PUT request
   * @returns true if success
   */
  Future<bool> put(String uri, String body) async {
    var res = await http.put(uri, body: body).timeout(
      Duration(seconds: timeoutInSeconds),
      onTimeout: () => null,
    );;
    if(res == null) return false;
    if( res.statusCode != 200 
        || res.body.contains('error')
        || !res.body.contains('success')  ) {
      print( '[BridgeRequest.put()] - ERROR : ' + res.body.toString() );
      return false;
    }
    return true;
  }

  /**
   * Send POST request
   * @returns <String>response.body
   */
  Future<String> post(String uri, String body) async {
    var res = await http.put(uri, body: body).timeout(
      Duration(seconds: timeoutInSeconds),
      onTimeout: () => null
    );;
    if(res == null) return "";
    if( res.statusCode != 200 
        || res.body.contains('error')
        || !res.body.contains('success')  ) {
      print( '[BridgeRequest.post()] - ERROR : ' + res.body.toString() );
      return "";
    }
    return res.body;
  }

  /**
   * Send GET request
   * @returns <String>response.body
   */
  Future<String> get(String uri) async {
    var res = await http.get(uri).timeout(
      Duration(seconds: timeoutInSeconds),
      onTimeout: () => null,
    );;
    if(res == null) return "";
    if( res.statusCode != 200 
        || res.body.contains('error')
        || !res.body.contains('success')  ) {
      print( '[BridgeRequest.get()] - ERROR : ' + res.body.toString() );
      return "";
    }
    return res.body;
  }
  


}