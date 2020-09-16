import 'package:http/http.dart' as http;

class BridgeRequest {



  /**
   * Send PUT request, returns true if success
   */
  Future<bool> put(String uri, String body) async {
    var res = await http.put(uri, body: body);
    if( res.statusCode != 200 
        || res.body.contains('error')
        || !res.body.contains('success')  ) {
      print( '[BridgeRequest.put()] - ERROR when trying to update state: ' + res.body.toString() );
      return false;
    }
    return true;
  }


}