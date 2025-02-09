import 'dart:convert';
import 'dart:developer';

import 'package:pollutant_inspection/models/constants.dart';
import 'package:pollutant_inspection/models/pollutant_register_model.dart';
import 'package:http/http.dart' as http;

import '../models/SIMA_login_info.dart';
import '../models/my_result.dart';

class GetLoginInfo {
  Future<MyResult> getData(String? token) async {
    try {
      var url = Uri.https(Constants.baseURL, Constants.getLoginData, {'token': token});
      print("url get login data : " + url.toString());
      var res = await http.get(url).timeout(
        const Duration(seconds: Constants.requestTimeOutSecond),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); //408 Request Timeout response status code
        },
      );
      //SIMALoginInfo? objRes;
      // if(res.statusCode==200)
      //   {
      if (res != null) return MyResult.convert(res);
      else return MyResult.nullReturn();
      //      print(res.statusCode);
      // var mapRes= jsonDecode(res.body);
      //print(mapRes['data']['token']);
      // objRes=SIMALoginInfo.fromJson(mapRes['data']);
      // print(res.statusCode);
      //       print(objRes.carTypes[1].title);

      // if(mapRes['statusCode']==0)
      //   {
      //     return objRes;
      //   }
      // }
      // ///TODO print
      // print("-------------------------------------------------------------------------------------------------------------------");
      // print(res.statusCode);
      // print(res.body.length);
      // print("+------------------------------------------------------------------------------------------------------------------");
    } catch (e) {
      print(e);
      return MyResult.catchReturn(e.toString());
      // throw;
    }
  }
}
