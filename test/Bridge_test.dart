import 'package:philips_hue_dart/Hue/Hue.dart';
import 'package:test/test.dart';

void main() {
  test('user could not access lights without valid username ', () async {
    final Bridge bridge = new Bridge("x.x.x.x");
    bool c = false;
    try {
      List<Light> lights = await Light.getAll(bridge);
      c = true;
    } catch (e) {
      c = false;
    }
    expect(c, false);
  });

  test('when no internet connection, getBridgeAuto() returns an exception.',
      () async {
    if (await isInternetConnected()) {
      print(
          '/!\ disconnect your computer from internet to validate this unit test /!\\');
      expect(false, false);
      return;
    }

    try {
      final Bridge bridge = await Bridge.getBridgeAuto();
      expect(true, false);
    } catch (e) {
      expect(true, true);
    }
  });
}
