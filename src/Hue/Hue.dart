import 'package:http/http.dart' as http;
import 'dart:convert';  //  JSON serialisation


abstract class Device { }

class Hue extends Device {      //  https://developers.meethue.com/develop/hue-api/
  
  //  |-------------->    Private attributes
  String _id;
  String _ip; 
  String _username;

  //  |-------------->    Constructor
  Hue(String id, String ip, {String username}) {
    this._id = id;
    this._ip = ip;
    this._username = username;
  }

  //  |-------------->    Getters / Setters
  String get id => _id;
  String get ip => _ip;
  String get username => _username;
  void set username(String uname) { this._username = uname; }

  //  |-------------->    Static Methods
  static getBridge() async {
    var res = await http.get("https://discovery.meethue.com/");
    if(res.statusCode != 200) {
      print('ERREUR DETECTION BRIDGE !');
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    }
    List bridges = jsonDecode(res.body);
    if(bridges.length==0 || res.statusCode!=200) return null;
    
    var bridge = bridges[0];
    return new Hue(bridge['id'], bridge['internalipaddress']);
  }

  //  |-------------->    Instance Methods

  /**
   * Generate bridge username
   */
  Future<bool> generateUsername(String deviceType) async {
    var res = await http.post('http://${this._ip}/api/', body: '{"devicetype":"${deviceType}"}');
    if(res.body.contains('success') && res.body.contains('username')) {
      this._username = jsonDecode(res.body)[0]['success']['username'];
      return true;
    } else {
      print("Failed getUsername() : " + res.body.toString());
      return false;
    }
  }

  /**
   * Get list of available lights
   */
  getLights() async {
    if(this.username==null) throw 'Cannot getLights() without valid username.';
    
    var res = await http.get('http://${this.ip}/api/${this.username}/lights');
    if(res.statusCode != 200) return null;

    return res.body;
    
  }

  /**
   * Debug
   */
  String toString() {
    String res = '';
    res += '\x1B[94mBRIDGE\t{ID:\t${this.id}\tIPv4:\t${this.ip}\tusername:\t${this.username}}\x1B[0m';
    return res;
  }

}





