import 'package:http/http.dart' as http;
import '../core/Bridge.dart';
import 'dart:convert';

/**
 * Appareil Philips HUE : Ampoule connectée
 */
class Light extends Bridge {
  Light(String ip, String username) : super(ip, username: username);

  //  Numéro pour les appels api --> /lights/${uid}/state
  int _uid;
  void setUID(int i) {
    _uid = i;
  }

  //  Attributs des ampoules
  bool _on;
  bool _reachable;
  String _type;
  String _name;
  String _modelid;
  String _productname;
  String _productid;
  String _uniqueid;

  //  Setters
  void set_on(bool s) {
    _on = s;
  }

  void set_reachable(bool s) {
    _reachable = s;
  }

  void set_type(String s) {
    _type = s;
  }

  void set_name(String s) {
    _name = s;
  }

  void set_modelid(String s) {
    _modelid = s;
  }

  void set_productname(String s) {
    _productname = s;
  }

  void set_productid(String s) {
    _productid = s;
  }

  void set_uniqueid(String s) {
    _uniqueid = s;
  }

  //  Getters
  bool get_on() => _on;
  bool get_reachable() => _reachable;
  String get_type() => _type;
  String get_name() => _name;
  String get_modelid() => _modelid;
  String get_productname() => _productname;
  String get_productid() => _productid;
  String get_uniqueid() => _uniqueid;

  /**
   * Switch ON light
   */
  Future<bool> off() async => await _setLightState("on", "false");

  /**
   * Switch OFF light
   */
  Future<bool> on() async => await _setLightState("on", "true");

  /**
   * Set lamp brightness (uint8 => from 1 to 254)
   */
  Future<bool> bri(int brightness) async {
    if (brightness < 1) brightness = 1;
    if (brightness > 254) brightness = 254;
    return await _setLightState("bri", '${brightness}');
  }

  /**
   * Saturation of the light. 254 is the most saturated (colored) and 0 is the least saturated (white).
   */
  Future<bool> sat(int saturation) async {
    if (saturation < 0) saturation = 0;
    if (saturation > 254) saturation = 254;
    return await _setLightState("sat", '${saturation}');
  }

  /**
   * Hue of the light. Programming 0 and 65535 would mean that the light will resemble the color red, 21845 for green and 43690 for blue.
   */
  Future<bool> hue(int hue) async {
    if (hue < 0) hue = 0;
    if (hue > 65535) hue = 65535;
    return await _setLightState("hue", '${hue}');
  }

  /**
   * Mired Color temperature of the light in Kelvin (153 to 500)
   */
  Future<bool> ct(int n) async {
    if (n < 153) n = 153;
    if (n > 500) n = 500;
    return await _setLightState("ct", '${n}');
  }

  Future<bool> _setLightState(String name, String value) async {
    if (this.username == null)
      throw 'Cannot _setLightState() without valid username.';
    bool stringIsBoolean(String s) {
      s = s.toLowerCase();
      return s == "true" || s == "false" ? true : false;
    }

    bool string2Bool(String s) {
      return s.toLowerCase() == "true" ? true : false;
    }

    final url = 'http://${ip}/api/${username}/lights/${_uid.toString()}/state';
    var res = await http.put(url,
        body:
            '{"${name}": ${stringIsBoolean(value) ? string2Bool(value) : value}}');
    if (res.statusCode != 200 ||
        res.body.contains('error') ||
        !res.body.contains('success')) {
      print(
          '[${get_name().toUpperCase()}] - ERROR when trying to update state: ' +
              res.body.toString());
      return false;
    }
    return true;
  }

  String toString() {
    return '''
      --- LIGHT (uid=${this._uid}) ---
      ON:\t\t${this._on.toString()}
      TYPE:\t\t${this._type}
      NAME:\t\t${this._name}
      MODELID:\t\t${this._modelid}
      PRODUCT_NAME:\t${this._productname}
      PRODUCT_ID:\t${this._productid}
      UNIQUE_ID:\t${this._uniqueid}
    ''';
  }

  /**
   * Get list of available lights
   */
  static Future<List<Light>> getAll(Bridge bridge,
      {bool onlyReachableLights = true}) async {
    if (bridge.username == null)
      throw 'Cannot getLights() without valid username.';

    var res =
        await http.get('http://${bridge.ip}/api/${bridge.username}/lights');
    if (res.statusCode != 200) return null;

    var lights = jsonDecode(res.body);
    //print(lights);
    print("LIGHTS FOUND : " + lights.length.toString());
    List<Light> availableLightsArray = new List<Light>();

    for (int i = 1; i <= lights.length; i++) {
      var lyt = lights[i.toString()];
      if (onlyReachableLights && lyt['state']['reachable'] != true) continue;

      //  create & append new light instance
      Light light = new Light(bridge.ip, bridge.username);
      light
        ..setUID(i)
        ..set_reachable(lyt['state']['reachable'])
        ..set_on(lyt['state']['on'])
        ..set_type(lyt['type'])
        ..set_name(lyt['name'])
        ..set_modelid(lyt['modelid'])
        ..set_productname(lyt['productname'])
        ..set_productid(lyt['productid'])
        ..set_uniqueid(lyt['uniqueid']);

      availableLightsArray.add(light);
    }
    return availableLightsArray;
  }
}
