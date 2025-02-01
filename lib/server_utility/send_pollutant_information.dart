import 'dart:convert';
import 'dart:io';

import 'package:pollutant_inspection/models/SIMA_login_info.dart';
import 'package:pollutant_inspection/models/constants.dart';
import 'package:pollutant_inspection/models/pollutant_register_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PollutantInformation {
  Future<http.Response?> send(
      /*SIMALoginInfo loginInfo,*/
      PollutantRegisterModel pollutantRegisterModel) async {
    try {
      //var token=loginInfo.token;
      var url = Uri.https(Constants.baseURL, Constants.registerPollutantPath);
      print(pollutantRegisterModel.toJson());
      var jsonBody = jsonEncode(pollutantRegisterModel.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var strLoginInfo = prefs.getString('loginInfo');
      var loginInfo = jsonDecode(strLoginInfo!);
      var token = loginInfo['token'];
      print(jsonBody + "=================================================jsonBody");
      var res = await http
          .post(url,
              headers: {
                // 'api-key': Constants.apiKey,
                'Content-Type': "application/json",
                'Authorization': 'Bearer $token',
              },
              body: jsonBody)
          .timeout(
        const Duration(seconds: Constants.requestTimeOutSecond),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); //408 Request Timeout response status code
        },
      );
      //TODO print
      print(res.statusCode);
      // print(res.body.replaceAllMapped(
      //   RegExp(r'\\u(\w{4})'),
      //       (Match match) => String.fromCharCode(int.parse(match.group(1)!, radix: 16)),
      // ));
      return res;
    } catch (e) {
      print(e);

      // throw;
    }
  }
}
