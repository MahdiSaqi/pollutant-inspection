import 'dart:convert';

import 'package:pollutant_inspection/models/my_result.dart';

import '../models/SIMA_base_definitions.dart';
import '../models/constants.dart';
import 'package:http/http.dart' as http;

class GetBaseDefinitions {
  Future<MyResult> getData(String? token) async {
    try {
      var url = Uri.https(Constants.baseURL, Constants.getBaseDefinition);
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

      // if (res.statusCode == 200) {
      //var mapRes = jsonDecode(res.body);
      //var objRes = MyResult.fromJson(mapRes);
      // if (objRes.statusCode == 0) {
      if (res != null)
        return MyResult.convert(res);
      else
        return MyResult.nullReturn(); // mapRes['data'].toString();
      // } else {
      //   objRes.errors?.add('خطای سامانه');
      //   return objRes;
      // }
      // } else {
      // return MyResult(statusCode: res.statusCode, errors: ['عدم پاسخ از سرور'], data: null);
      // }

      //SIMABaseDefinition? simaBaseDefinition;
    } catch (e) {
      // return MyResult(
      //   data: null,
      //   errors: ['خطای ناشناخته', e.toString()],
      //   statusCode: -1,
      // );
      return MyResult.catchReturn(e.toString());
    }
  }
}
