import 'package:philips_hue_dart/Hue/Hue.dart';

/**
 * This sample show how to detect a bridge on local network
 */


void main() => demo();

Future<void> demo() async {
  //  Get connected bridge on local network
  Hue bridge = await Hue.getBridge();

  if(bridge==null) {
    print("No bridge connected on local network.");
  } else {
    print("--- BRIDGE DETECTED ---");
    print(bridge);
    print('---*---');
  }
}

