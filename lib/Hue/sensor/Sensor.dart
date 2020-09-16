import '../core/Bridge.dart';


/**
 * Appareil Philips HUE : prise connectée
 */
class Sensor extends Bridge {
  Sensor(String id, String ip, String username) : super(id, ip, username: username);

  getAll() async {

  }

}