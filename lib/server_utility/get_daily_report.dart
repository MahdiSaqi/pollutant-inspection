import 'package:pollutant_inspection/models/my_result.dart';
import '../models/constants.dart';
import 'package:http/http.dart' as http;

class GetDailyReport {
  Future<MyResult> getData(String? token) async {
    try {
      var url = Uri.https(Constants.baseURL, Constants.getDailyReport);
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var res = await http.get(url, headers: headers).timeout(
        const Duration(seconds: Constants.requestTimeOutSecond),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); //408 Request Timeout response status code
        },
      );
      if (res != null)
        return MyResult.convert(res);
      else
        return MyResult.nullReturn(); // mapRes['data'].toString();
    } catch (e) {
      return MyResult.catchReturn(e.toString());
    }
  }
}
