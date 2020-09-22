import 'package:philips_hue_dart/Hue/Hue.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

/**
 * Les tests unitaires ci-dessous valiendt la mise en place
 * de l'environnement de demo à l'université
 * 
 * 
 * INSTALLATION :
 * - Mettre en place le routeur
 * - connecter le bridge au routeur via Ethernet
 * - connecter cet appareil au réseau du routeur (wifi ou ethernet...)
 */

void main() {
  final String ip = '192.168.1.5';
  final String usernameToken = 'wduRf8BKAppZ2noNbnpkp4r4pED0sas22A-1-UMV';
  final String router_ip = '192.168.1.1';

  test('check connection to router : ' + router_ip, () async {
    final res = await http.get('http://' + router_ip).timeout(
          Duration(seconds: 2),
          onTimeout: () => null,
        );
    ;
    if (res == null) return false;
    expect(res.body.length > 0, true);
  });

  test('check connection to Hue Bridge : ' + ip, () async {
    final Bridge bridge = await Bridge.getBridgeManually(ip);
    expect(bridge != null, true);
  });

  test('unlogged user request returns exeption', () async {
    final Bridge bridge = await Bridge.getBridgeManually(ip);
    bool c = false;
    try {
      List<Light> lights = await Light.getAll(bridge);
      c = false;
    } catch (e) {
      c = true;
    }
    expect(c, true);
  });

  test('check user token : ' + usernameToken, () async {
    final Bridge bridge = await Bridge.getBridgeManually(ip);
    bridge.username = usernameToken;
    final bool check = await bridge.hasAuthorizedUsername();
    expect(check, true);
  });

  test('detect at least one light connected to bridge', () async {
    final Bridge bridge = await Bridge.getBridgeManually(ip);
    bridge.username = usernameToken;
    List<Light> lights = await Light.getAll(bridge);
    expect(lights.length > 0, true);
  });
}
