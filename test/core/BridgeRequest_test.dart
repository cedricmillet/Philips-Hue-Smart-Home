import 'package:philips_hue_dart/Hue/Hue.dart';
import 'package:test/test.dart';

void main() {
  test('get() method must returns a response as string', () async {
    final String res = await new BridgeRequest().get('http://www.github.com');

    expect(res.length > 0, true);
  });
}
