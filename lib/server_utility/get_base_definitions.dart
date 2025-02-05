import 'dart:convert';

import '../models/SIMA_base_definitions.dart';
import '../models/constants.dart';
import 'package:http/http.dart' as http;

class GetBaseDefinitions {
  Future<String?> getData(String? token) async {
    try {
      var url = Uri.https(Constants.baseURL, Constants.getBaseDefinition);
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var res = await http.get(url, headers: headers).timeout(
        const Duration(seconds: Constants.requestTimeOutSecond),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(
              'Error', 408); //408 Request Timeout response status code
        },
      );

      if (res.statusCode == 200) {
        var mapRes = jsonDecode(res.body);
        if (mapRes['statusCode'] == 0) {
          return jsonEncode(mapRes['data']); // mapRes['data'].toString();
        } else {
          return '400';
        }
      } else {
        return '400';
      }

      //SIMABaseDefinition? simaBaseDefinition;
    } catch (e) {
      e.toString();
    }
  }
}
