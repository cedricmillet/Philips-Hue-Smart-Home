import 'package:philips_hue_dart/Hue/Hue.dart';
import 'package:philips_hue_dart/Hue/core/Bridge.dart';

/**
 * This sample show how to detect a bridge on local network
 */


void main() => demo();

Future<void> demo() async {
  //  Get connected bridge on local network
  Bridge bridge = await Bridge.getBridgeAuto();

  if(bridge==null) {
    print("No bridge connected on local network.");
  } else {
    print("--- BRIDGE DETECTED ---");
    print(bridge);
    print('---*---');
  }
}

