import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class MyResult {
  int? statusCode;
  List<String>? errors;
  String? data;

  MyResult({this.statusCode, this.errors, this.data});

  factory MyResult.fromJson(Map<String, dynamic> json) {
    return MyResult(
      statusCode: json['statusCode'] as int?,
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
      data: jsonEncode(json['data']), //json['data'] as String?,
    );
  }

  factory MyResult.convert(http.Response res) {
    if (res.statusCode == 200) {
      var mapRes = jsonDecode(res.body);
      var objRes = MyResult.fromJson(mapRes);
      return objRes; // mapRes['data'].toString();
    } else {
      return MyResult(statusCode: res.statusCode, errors: ['عدم پاسخ از سرور'], data: null);
    }
  }

  factory MyResult.nullReturn() {
    return MyResult(statusCode: -1, errors: ['پاسخ خالی از سرور'], data: null);
  }
  factory MyResult.catchReturn(String exceptionError) {
    return MyResult(statusCode: -2, errors: ['خطای ناشناخته',exceptionError], data: null);
  }

}
