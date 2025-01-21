
import 'package:flutter/material.dart';
import 'package:pollutant_inspection/pages/pollutant_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  final String info="";

  LandingPage({Key? key}) : super(key: key) {
    var loginInfo = _loadLoginInfo();

  }


  Future<String?> _loadLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginInfo'); // Return the login info
  }



  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('نرم افزار ثبت خودروهای آلاینده'),),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PollutantRegister()));
                },
                    child: Text('ثبت خودروی آلاینده')
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('گزارش'),
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text('خروج از حساب کاربری'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
