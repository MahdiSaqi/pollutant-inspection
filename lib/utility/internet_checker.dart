import 'dart:io';
class Internet{
  static Future<bool> check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //connected
        return true;
      }
    } catch (e) {
      //   print('false3333');
      return false;
    }
    return false;
  }
}

