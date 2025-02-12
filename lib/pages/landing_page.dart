// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:pollutant_inspection/pages/daily_report.dart';
// import 'package:pollutant_inspection/pages/pollutant_register.dart';
// import 'package:pollutant_inspection/utility/get_current_location.dart';
// import 'package:pollutant_inspection/utility/show_modal_error.dart';
// import 'package:pollutant_inspection/widgets/logined_user.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../server_utility/get_base_definitions.dart';
//
// class LandingPage extends StatelessWidget {
//   LandingPage({Key? key}) : super(key: key) {}
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             title: Text('سامانه نظارت و بازرسی خودروهای آلاینده'),
//           ),
//           body: SafeArea(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     LoginedUser(),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ElevatedButton(
//                         onPressed: () async {
//                           try {
//                             var prefs = await SharedPreferences.getInstance();
//                             String? strLoginInfo = prefs?.getString('loginInfo');
//                             if (strLoginInfo != null) {
//                               var loginInfo = jsonDecode(strLoginInfo);
//                               var myRes = await GetBaseDefinitions().getData(loginInfo['token']);
//                               if (myRes.statusCode == 0)
//                                 prefs?.setString('baseDefinitions', myRes.data!);
//                               else {
//                                 ShowModal(
//                                   content: myRes.errors.toString(),
//                                   title: myRes.statusCode.toString(),
//                                 ).Message(context);
//                               }
//                             }
//                           } catch (e) {
//                             e.toString();
//                           }
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => PollutantRegister()));
//                         },
//                         child: Text(
//                           'صدور اخطار خودروی آلاینده',
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         )),
//                     Container(
//                       margin: EdgeInsets.all(20),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context, MaterialPageRoute(builder: (context) => DailyReport()));
//                         },
//                         child: Text(
//                           'گزارش عملیات',
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         var prefs = await SharedPreferences.getInstance();
//                         prefs.clear();
//                         //Restart.restartApp();
//                       },
//                       child: Text(
//                         'خروج از حساب کاربری',
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     //GetCurrentLocation(),///for test
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

///*******************************************
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pollutant_inspection/main.dart';
import 'package:pollutant_inspection/pages/daily_report.dart';
import 'package:pollutant_inspection/pages/pollutant_register.dart';
import 'package:pollutant_inspection/utility/get_current_location.dart';
import 'package:pollutant_inspection/utility/show_modal_error.dart';
import 'package:pollutant_inspection/widgets/logined_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/constants.dart';
import '../server_utility/get_base_definitions.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key) {}


  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(Constants.appTitle),
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
                              var myRes = await GetBaseDefinitions().getData(loginInfo['token']);
                              if (myRes.statusCode == 0) {
                                prefs?.setString('baseDefinitions', myRes.data!);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => PollutantRegister()));
                              } else {
                                ShowModal(
                                  content: myRes.errors.toString(),
                                  title: myRes.statusCode.toString(),
                                ).Message(context);
                              }
                            }
                          } catch (e) {}
                        },
                        child: Text(
                          'صدور اخطار خودروی آلاینده',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => DailyReport()));
                        },
                        child: Text(
                          'گزارش عملیات',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyHomePage(title: 'title')),
                          // Replace with your actual login screen widget
                              (route) => false, // Remove all previous routes
                        );
                      },
                      child: Text(
                        'خروج از حساب کاربری',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
