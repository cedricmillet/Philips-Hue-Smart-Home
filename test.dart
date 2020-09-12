
import 'src/Hue/Hue.dart';

void main() {
  init();
}



void init() async {
  print('--- STARTING ---');

  Hue bridge = await Hue.getBridge();
  bridge.username = 'wduRf8BKAppZ2noNbnpkp4r4pED0sas22A-1-UMV';


  if(bridge!=null) {
    if(bridge.username == null) {
      print('AUCUN USERNAME DETECTE... GENERATION.');
      bool generation = await bridge.generateUsername('chambre_cedric');
      if(generation) { }
    }

    print(bridge);
    print(await bridge.getLights());
  }




  print('--- END OF INIT() ---');
}

