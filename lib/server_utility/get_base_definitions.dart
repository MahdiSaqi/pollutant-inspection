import 'dart:convert';

import '../models/SIMA_base_definitions.dart';
import '../models/constants.dart';
import 'package:http/http.dart' as http;

class GetBaseDefinitions {

  Future<String?> getData(String? token)  async {
    try {
        var url = Uri.http(Constants.baseURL, Constants.getLoginData ,{'token':token});
        print("url get login data : " +  url.toString());
        var res = await http.get(url)
            .timeout(
        const Duration(seconds: Constants.requestTimeOutSecond),
        onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
        'Error', 408); //408 Request Timeout response status code
        },
        );

        if(res.statusCode == 200)
          {
            var mapRes=jsonDecode(res.body);
            if(mapRes['statusCode']==0)
              {
                return mapRes['data'];
              }
          }

        //SIMABaseDefinition? simaBaseDefinition;

  }catch (e){

  }

  }
}