import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Light.dart';  //  JSON serialisation


abstract class Device { }

/**
 * Hue bridge device entity
 */
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

  /**
   * Detect and get bridge automatically
   */
  static Future<Hue> getBridgeAuto() async {
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

  /**
   * Detect and get Hue bridge manually
   */
  static Future<Hue> getBridgeManually(String internalipaddress) async {
    final Hue manualBridge = new Hue(null, internalipaddress);
    return (await Hue.exists(manualBridge)) ? manualBridge : null;
  }

  /**
   * Check if specified bridge is reachable on local network
   */
  static Future<bool> exists(Hue hueBridge) async {
    var res = await http.get('http://${hueBridge.ip}/api/config');
    if(res.statusCode != 200) return false;
    if(res.body.length==0 || res.body.contains('error'))  return false;
    return true;
  }

  //  |-------------->    Instance Methods

  /**
   * Generate new bridge username
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
   * Debug
   */
  String toString() {
    String res = '';
    res += '\x1B[94mBRIDGE\t{ID:\t${this._id}\tIPv4:\t${this._ip}\tusername:\t${this._username}}\x1B[0m';
    return res;
  }

}





