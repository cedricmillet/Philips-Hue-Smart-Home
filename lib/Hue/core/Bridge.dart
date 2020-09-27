import 'dart:convert';
import '../Hue.dart';
import 'BridgeRequest.dart';
import 'misc.dart';

class Bridge extends Hue {
  //  https://developers.meethue.com/develop/hue-api/

  //  |-------------->    Private attributes
  String _ip;
  String _username;

  //  |-------------->    Constructor
  Bridge(String ip, {String username}) {
    this._ip = ip;
    this._username = username;
  }

  //  |-------------->    Getters / Setters
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
    if (!await isInternetConnected()) return null;
    final String resBody =
        await new BridgeRequest().get('https://discovery.meethue.com/');
    if (resBody.length == 0) return null;
    List bridges = jsonDecode(resBody);
    if(bridges.length == 0) return null;
    
    var bridge = bridges[0];
    return new Bridge(bridge['internalipaddress']);
  }

  /**
   * Detect and get Hue bridge manually
   */
  static Future<Bridge> getBridgeManually(String internalipaddress) async {
    final Hue manualBridge = new Bridge(internalipaddress);
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

  Future<bool> hasAuthorizedUsername() async {
    final String resBody = await new BridgeRequest()
        .get('http://${this._ip}/api/${this.username}');
    //print(resBody);
    if (resBody.length == 0) return false;
    return (resBody.contains('lights')) ? true : false;
  }

  /**
   * Debug
   */
  String toString() {
    String res = '';
    res +=
        '\x1B[94mBRIDGE\tIPv4:\t${this._ip}\tusername:\t${this._username}}\x1B[0m';
    return res;
  }
}
