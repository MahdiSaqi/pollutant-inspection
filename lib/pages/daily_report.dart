import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pollutant_inspection/server_utility/get_daily_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/show_modal_error.dart';

class DailyReport extends StatelessWidget {
  // Sample data in a list of maps
  DailyReport() {
    _initialize();
  }

  List<Map<String, dynamic>> data = [];

  _initialize() async {
    var prefs = await SharedPreferences.getInstance();
    String? strLoginInfo = prefs?.getString('loginInfo');
    if (strLoginInfo != null) {
      var loginInfo = jsonDecode(strLoginInfo);
      var myRes = await GetDailyReport().getData(loginInfo['token']);
    if (myRes.statusCode == 0) {
      var resDara = jsonDecode(myRes.data!);
       var data1=resDara['items'];
      print('object');
    }
    // else {
    //   ShowModal(
    //     content: myRes.errors.toString(),
    //     title: myRes.statusCode.toString(),
    //   ).Message(context as BuildContext);
    // }
    }

    data = [
      {'id': 1, 'name': 'تست', 'age': 'تست'},
      {'id': 2, 'name': 'تست', 'age': 'تست'},
      {'id': 3, 'name': 'تست', 'age': 'تست'},
      {'id': 4, 'name': 'تست', 'age': 'تست'},
      {'id': 5, 'name': 'تست', 'age': 'تست'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('گزارش عملیات'),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerRight,
            child: DataTable(
              columns: [
                DataColumn(label: Text('ردیف')),
                DataColumn(label: Text('نام مالک')),
                DataColumn(label: Text('نوع خودرو')),
              ],
              rows: data.map((item) {
                return DataRow(cells: [
                  DataCell(Text(item['id'].toString())), // Convert ID to String
                  DataCell(Text(item['name'])),
                  DataCell(Text(item['age'].toString())), // Convert Age to String
                ]);
              }).toList(), // Convert Iterable to List
            ),
          ),
        ),
      ),
    );
  }
}
