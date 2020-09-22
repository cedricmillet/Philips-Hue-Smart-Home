import 'dart:io';

/**
 * Check internet connection by pinging google.com
 */
Future<bool> isInternetConnected() async {
  bool flag = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) flag = true;
  } catch (e) {}
  return flag;
}
