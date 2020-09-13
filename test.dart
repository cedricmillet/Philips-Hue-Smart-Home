
import 'lib/Hue/Hue.dart';
import 'lib/Hue/Light.dart';

void main() {
  init();
}



void init() async {
  print('--- STARTING ---');

  //  Get connected bridge on local network
  Hue bridge = await Hue.getBridgeAuto();
  if(bridge==null) throw "BRIDGE INTROUVABLE";

  //  DEV ONLY
  bridge.username = 'wduRf8BKAppZ2noNbnpkp4r4pED0sas22A-1-UMV';

  //  PROD ONLY
  if(bridge.username == null) {
    print('AUCUN USERNAME DETECTE... GENERATION.');
    bool generation = await bridge.generateUsername('chambre_cedric');
    if(generation) {
      print('La generation de votre username est un success : ${bridge.username}');
    }
  }

  print(bridge);

  //  Get all lights 
  List<Light> lights = await Light.getAll(bridge, {true});

  //  Display lights data
  for (Light l in lights) {
    print(">>>>>>>>>>>>");
    print(l);
    print("<<<<<<<<<<<<");
  }

  //  Switch OFF all lights
  for (Light l in lights) {
    //l.on();
    //l.bri(50);
    l..on()..bri(10);
  }

  
  
  //  Manipulate specific light
  Light m = lights[0] as Light;
  print('STATE: ${m.get_on()}');

  print('--- END OF INIT() ---');
}

