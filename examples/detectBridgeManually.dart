import 'package:philips_hue_dart/Hue/Hue.dart';

/**
 * This sample show how to detect a bridge on local network
 */

void main() => demo();

Future<void> demo() async {
  //  Get connected bridge on local network
  Bridge bridge = await Bridge.getBridgeManually('192.168.1.5');
  bridge.username = 'wduRf8BKAppZ2noNbnpkp4r4pED0sas22A-1-UMV';

  if (bridge == null) {
    print("No bridge connected on local network.");
  } else {
    print("--- BRIDGE DETECTED ---");
    print(bridge);
    print('---*---');

    List<Light> lights = await Light.getAll(bridge);
    for (Light light in lights) {
      bool t = await light.off();
      print(t ? 'Light successfully updated' : 'Error when updating light');
    }
  }
}
