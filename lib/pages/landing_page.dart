import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pollutant_inspection/pages/pollutant_register.dart';
import 'package:pollutant_inspection/utility/get_current_location.dart';
import 'package:pollutant_inspection/widgets/logined_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../server_utility/get_base_definitions.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('سامانه نظارت و بازرسی خودروهای آلاینده'),
          ),
          body: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    LoginedUser(),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            var prefs = await SharedPreferences.getInstance();
                            String? strLoginInfo = prefs?.getString('loginInfo');
                            if (strLoginInfo != null) {
                              var loginInfo = jsonDecode(strLoginInfo);
                              var baseDef = await GetBaseDefinitions().getData(loginInfo['token']);
                              prefs?.setString('baseDefinitions', baseDef!);
                            }
                          } catch (e) {}
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => PollutantRegister()));
                        },
                        child: Text(
                          'صدور اخطار خودروی آلاینده',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('گزارش عملیات',
                          style: TextStyle(
                            fontSize: 20,
                          ),),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                      },
                      child: Text('خروج از حساب کاربری',
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                    ),
                    //GetCurrentLocation(),///for test
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
