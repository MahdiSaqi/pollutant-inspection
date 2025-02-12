import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pollutant_inspection/server_utility/get_daily_report.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/show_modal_error.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({Key? key}) : super(key: key);

  @override
  _DailyReportState createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true; // To manage loading state

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    var prefs = await SharedPreferences.getInstance();
    String? strLoginInfo = prefs.getString('loginInfo');

    if (strLoginInfo != null) {
      var loginInfo = jsonDecode(strLoginInfo);
      var myRes = await GetDailyReport().getData(loginInfo['token']);
      if (myRes.statusCode == 0) {
        var resData = jsonDecode(myRes.data!);
        setState(() {
          data = List<Map<String, dynamic>>.from(
              resData['items']); // Ensure the data is in the correct format
          isLoading = false; // Update loading state
        });
      } else {
        // Handle error
        ShowModal(
          content: myRes.errors.toString(),
          title: myRes.statusCode.toString(),
        ).Message(context);
      }
    } else {
      // Handle case where login info is not present
      setState(() {
        isLoading = false; // Update loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('گزارش عملیات'),
        ),
        body: isLoading // Show loading indicator while fetching data
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('ردیف')), // Row number column
                      DataColumn(label: Text('نام مالک')),
                      DataColumn(label: Text('نوع خودرو')),
                    ],
                    rows: data.asMap().entries.map((entry) {
                      int index = entry.key; // Get the index
                      var item = entry.value; // Get the item

                      return DataRow(cells: [
                        DataCell(Text((index + 1).toString())), // Use index + 1 for row number
                        DataCell(Text(item['ownerName'] ?? '')), // Handle null values
                        DataCell(Text(item['carPlate'].toString())), // Convert Age to String
                      ]);
                    }).toList(), // Convert Iterable to List
                  ),
                ),
              ),
      ),
    );
  }
}
