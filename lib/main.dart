import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pollutant_inspection/models/SIMA_base_definitions.dart';
import 'package:pollutant_inspection/pages/landing_page.dart';
import 'package:pollutant_inspection/pages/officer_selection.dart';
import 'package:pollutant_inspection/pages/pollutant_register.dart';
import 'package:pollutant_inspection/pages/web_login.dart';
import 'package:pollutant_inspection/server_utility/get_base_definitions.dart';
import 'dart:io';
import 'package:pollutant_inspection/server_utility/get_login_key.dart';
import 'package:pollutant_inspection/utility/internet_checker.dart';
import 'package:pollutant_inspection/utility/loding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/constants.dart'; //test http#1

void main() {
  HttpOverrides.global = MyHttpOverrides(); //test http#2
  runApp(const MyApp());
}

//test http#3
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Constants.appTitle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'B Yekan',
        useMaterial3: true,
      ),
      home: const MyHomePage(title: Constants.appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class NavigateToWebLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NavigateToWebLoginState();
}

class _NavigateToWebLoginState extends State<NavigateToWebLogin> {
  String loginMessage = "...در حال اتصال به سامانه پایش";
  Timer? _timer;
  bool isRetry = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      prefs = await SharedPreferences.getInstance();
      String? strLoginInfo = prefs?.getString('loginInfo');
      if (strLoginInfo != null) {
        var loginInfo = jsonDecode(strLoginInfo);
        var myRes = await GetBaseDefinitions().getData(loginInfo['token']);
        if (myRes.statusCode == 0) {
          var strOfficer = prefs?.getString('officer');
          var officer = jsonDecode(strOfficer!);
          if (int.parse(officer['id']) == -1)
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OfficerSelection()
                    //OfficerSelection()
                    ));
          else
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()
                    //OfficerSelection()
                    ));

          ///is code for test on local
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Container(child: WebLogin("test"))
          //         // PollutantRegister()
          //         ));
        } else {
          loginKey();
        }
      } else {
        loginKey();

        ///is code for test on local
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Container(child: WebLogin("test"))
        //         // PollutantRegister()
        //         ));
      }
    } catch (e) {
      loginKey();

      ///is code for test on local
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Container(child: WebLogin("test"))
      //         // PollutantRegister()
      //         ));
    }
  }

  loginKey() async {
    try {
      // _timer = new Timer(const Duration(milliseconds: 3000), () async {
      //   if (await Internet.check() == false) {
      //     setState(() {
      //       isRetry = true;
      //       loginMessage = 'اتصال به اینترنت را بررسی کنید';
      //     });
      //     return;
      //   }
      if (Constants().isDevelop)
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Container(child: WebLogin('loginKey'))
                // PollutantRegister()
                ));

      Loading.open(context);
      var res = await Login().getLoginKey();
      Loading.close(context);

      if (res != null && res.statusCode == 0) {
        var loginKey = jsonDecode(res.data!);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Container(child: WebLogin(loginKey))
                // PollutantRegister()
                ));
      } else if (res?.statusCode == -2) {
        setState(() {
          isRetry = true;
          loginMessage = "خطای ارتباط با اینترنت";
        });
      } else {
        setState(() {
          isRetry = true;
          if (res != null) {
            // print(res.statusCode);
            loginMessage = "";
            for (var i in res.errors!) loginMessage += i + "\n";
          } else {
            loginMessage = 'خطای ناشناخته!';
          }
        });
      }
      // });
    } catch (e) {
      e.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    //_timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isRetry == false) LinearProgressIndicator(),
        Text(loginMessage),
        if (isRetry == true)
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isRetry = false;
                  loginMessage = "ورود به صفحه لاگین";
                });
                _initialize();
              },
              child: Text("تلاش مجدد"))
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align title to the right
          children: [
            Text(widget.title),
          ],
        ),
      ),
      body: Center(
        child: NavigateToWebLogin(),
      ),
    );
  }
}
