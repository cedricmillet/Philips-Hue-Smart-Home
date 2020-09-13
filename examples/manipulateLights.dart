import 'package:philips_hue_dart/Hue/Hue.dart';
import 'package:philips_hue_dart/Hue/Light.dart';

/**
 * This example show how to manipulate Philips Hue Lights
 */


void main() => demo();

Future<void> demo() async {
  //  Get connected bridge on local network
  Hue bridge = await Hue.getBridgeAuto();
  if(bridge==null) throw 'No Philips Hue Bridge on local network.';

  //  Test credentials
  bridge.username = 'wduRf8BKAppZ2noNbnpkp4r4pED0sas22A-1-UMV';

  //  Get all lights 
  List<Light> lights = await Light.getAll(bridge);
  if(lights.length == 0) throw 'No light detected.';

  //  Display lights data
  for (Light l in lights) {
    print(">>>>>>>>>>>>");
    print(l);
    print("<<<<<<<<<<<<");
  }

  //  Switch OFF all lights
  for (Light l in lights)
    l.off();
  
  //  Manipulate specific light
  Light m = lights[0] as Light;
  print('STATE: ${m.get_on()}');

}

