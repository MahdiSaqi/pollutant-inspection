
import 'package:flutter/material.dart';
import 'package:pollutant_inspection/pages/pollutant_register.dart';
import 'package:pollutant_inspection/widgets/logined_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {

  LandingPage({Key? key}) : super(key: key) {
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
                LoginedUser(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PollutantRegister()));
                },
                    child: Text('ثبت خودروی آلاینده')
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('گزارش عملیات'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.clear();


                    },
                    child: Text('خروج از حساب کاربری'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
