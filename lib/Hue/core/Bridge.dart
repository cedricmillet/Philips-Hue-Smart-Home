import 'dart:convert';
import '../Hue.dart';
import 'BridgeRequest.dart';

class Bridge extends Hue {
  //  https://developers.meethue.com/develop/hue-api/

  //  |-------------->    Private attributes
  String _id;
  String _ip;
  String _username;

  //  |-------------->    Constructor
  Bridge(String id, String ip, {String username}) {
    this._id = id;
    this._ip = ip;
    this._username = username;
  }

  //  |-------------->    Getters / Setters
  String get id => _id;
  String get ip => _ip;
  String get username => _username;
  void set username(String uname) {
    this._username = uname;
  }

  //  |-------------->    Static Methods

  /**
   * Detect and get bridge automatically
   */
  static Future<Bridge> getBridgeAuto() async {
    final String resBody =
        await new BridgeRequest().get('https://discovery.meethue.com/');
    if (resBody.length == 0) return null;
    List bridges = jsonDecode(resBody);
    var bridge = bridges[0];
    return new Bridge(bridge['id'], bridge['internalipaddress']);
  }

  /**
   * Detect and get Hue bridge manually
   */
  static Future<Bridge> getBridgeManually(String internalipaddress) async {
    final Hue manualBridge = new Bridge(null, internalipaddress);
    return (await Bridge.exists(manualBridge)) ? manualBridge : null;
  }

  /**
   * Check if specified bridge is reachable on local network
   */
  static Future<bool> exists(Bridge hueBridge) async {
    final String resBody =
        await (new BridgeRequest().get('http://${hueBridge.ip}/api/config'));
    if (!resBody.contains('name') || !resBody.contains('bridgeid'))
      return false;
    return true;
  }

  //  |-------------->    Instance Methods

  /**
   * Generate new bridge username
   */
  Future<bool> generateUsername(String deviceType) async {
    final String resBody = await new BridgeRequest()
        .post('http://${this._ip}/api/', '{"devicetype":"${deviceType}"}');
    if (resBody.length == 0) return false;
    if (!resBody.contains('username')) return false;
    this._username = jsonDecode(resBody)[0]['success']['username'];
  }

  /**
   * Debug
   */
  String toString() {
    String res = '';
    res +=
        '\x1B[94mBRIDGE\t{ID:\t${this._id}\tIPv4:\t${this._ip}\tusername:\t${this._username}}\x1B[0m';
    return res;
  }
}
