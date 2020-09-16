import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:philips_hue_dart/Hue/core/BridgeRequest.dart';




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
    final String resBody = await new BridgeRequest().get('https://discovery.meethue.com/');
    if(resBody.length == 0) return null;
    List bridges = jsonDecode(resBody);
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
    final String resBody = await new BridgeRequest().get('http://${hueBridge.ip}/api/config');
    if(resBody.length == 0) return false;
    return true;
  }

  //  |-------------->    Instance Methods

  /**
   * Generate new bridge username
   */
  Future<bool> generateUsername(String deviceType) async {
    final String resBody = await new BridgeRequest().post('http://${this._ip}/api/', '{"devicetype":"${deviceType}"}');
    if(resBody.length == 0) return false;
    if(!resBody.contains('username')) return false;
    this._username = jsonDecode(resBody)[0]['success']['username'];
  }

  /**
   * Debug
   */
  String toString() {
    String res = '';
    res += '\x1B[94mBRIDGE\t{ID:\t${this._id}\tIPv4:\t${this._ip}\tusername:\t${this._username}}\x1B[0m';
    return res;
  }

  /**
   * usefull functions for childrens
   */
  static bool stringIsBoolean(String s) { s = s.toLowerCase();  return s=="true"||s=="false" ? true : false; }
  static bool string2Bool(String s) { return s.toLowerCase()=="true" ? true : false;  }
}


