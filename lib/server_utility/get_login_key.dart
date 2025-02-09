// import 'dart:io';
// import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:convert';
import 'package:pollutant_inspection/models/constants.dart';
import 'package:pollutant_inspection/models/my_result.dart';

class Login
{
  Future<MyResult?> getLoginKey() async
  {
    try {
      var url = Uri.https(Constants.baseURL,Constants.getLoginKeyPath);
      var res = await http.get(url
          ,headers: {
            //'api-key': Constants.apiKey,
          }
      ).timeout(
        const Duration(seconds:Constants.requestTimeOutSecond),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error',408); //408 Request Timeout response status code
        },
      );
      // MyResult? objRes;

      //TODO print
      print("++++++++++++++++++++++++++++++++++++++++++++++++++");
      print(res.body+'   '+res.statusCode.toString());
      // var testResponse='{"statusCode":403,"errors":["Client info missmatched"],"data":null}';
      // if(res.statusCode==200)
      //   {
      //     var mapRes= jsonDecode(res.body);
      //     objRes=MyResult.fromJson(mapRes);
      //
      //     if(objRes.statusCode==0)
      //       {
      //         return objRes;
      //       }
      //     else
      //       {
      //         objRes.errors?.add('خطای ارتباط با سامانه لاگین');
      //         return objRes;
      //       }
      //   }
      // else
      //   {
      //     objRes= MyResult(
      //         //سه خط زیر برای زمان تست می باشد
      //         // data: '88888888888888888888888888',
      //         // errors:[] ,
      //         // statusCode:200,
      //
      //         errors:['خطای ارتباط با سرور پایش','اتمام زمان'],
      //         statusCode:res.statusCode
      //     );
      //     return objRes;
      //   }
      if(res != null) return MyResult.convert(res);
      else MyResult.nullReturn();
    }
    on SocketException catch(e)
    {
      return MyResult.catchReturn(e.toString());
      //TODO print
      print("not connected");
      // return MyResult(
      //   statusCode: 101,
      //   errors: ['خطای ارتباط با سرور پایش'],
      // );
    }
  }
}
