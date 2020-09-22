import '../core/Bridge.dart';

/**
 * Appareil Philips HUE : prise connectée
 */
class Sensor extends Bridge {
  Sensor(String ip, String username) : super(ip, username: username);

  getAll() async {}
}
