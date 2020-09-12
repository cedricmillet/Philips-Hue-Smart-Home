
import 'src/Hue/Hue.dart';
import 'src/Hue//Light.dart';

void main() {
  init();
}



void init() async {
  print('--- STARTING ---');

  //  Get connected bridge on local network
  Hue bridge = await Hue.getBridge();
  if(bridge==null) throw "BRIDGE INTROUVABLE";

  //  DEV ONLY
  bridge.username = 'wduRf8BKAppZ2noNbnpkp4r4pED0sas22A-1-UMV';

  //  PROD ONLY
  if(bridge.username == null) {
    print('AUCUN USERNAME DETECTE... GENERATION.');
    bool generation = await bridge.generateUsername('chambre_cedric');
    if(generation) { }
  }

  print(bridge);

  //  Get all lights 
  var lights = await bridge.getLights();

  //  Display lights data
  for (var l in lights) {
    print(">>>>>>>>>>>>");
    print(l);
    print("<<<<<<<<<<<<");
  }

  //  Switch OFF all lights
  for (var l in lights)
    l.off();



  print('--- END OF INIT() ---');
}

