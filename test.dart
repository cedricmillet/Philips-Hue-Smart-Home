
import 'src/Hue/Hue.dart';
import 'src/Hue//Light.dart';

void main() {
  init();
}



void init() async {
  print('--- STARTING ---');

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

  //  LIGHTS 
  await bridge.getLights();

  Light light = (
    LightBuilder(bridge.id, bridge.ip, bridge.username)
    ..set_name('Mon nom')
    ..set_on(true)
    ..set_type('mon type')
  ).build(); 
  print(light);





  print('--- END OF INIT() ---');
}

