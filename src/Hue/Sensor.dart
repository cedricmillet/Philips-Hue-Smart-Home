import 'Hue.dart';

/**
 * Appareil Philips HUE : prise connectée
 */
class Sensor extends Hue {
  Sensor(String id, String ip, String username) : super(id, ip, username: username);

  getAll() async {

  }

}