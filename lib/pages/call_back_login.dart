//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CallBackLogin extends StatelessWidget {
//   const CallBackLogin({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body:Text("data"),
//     ) ;
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/constants.dart';
import '../server_utility/get_base_definitions.dart';
import '../server_utility/get_login_info.dart';
import '../utility/loding.dart';
import 'officer_selection.dart';

class CallBackLogin extends StatefulWidget {
  String loginKey;

  CallBackLogin(this.loginKey);

  @override
  _CallBackLoginState createState() => _CallBackLoginState();
}

class _CallBackLoginState extends State<CallBackLogin> {
  StreamSubscription? _sub;
  String? _latestLink;

  @override
  void initState() {
    super.initState();
    // handle initial link when app is launched by a link
    _initInitialUri();

    launchUrl(Uri.parse(Constants.loginPageUri + widget.loginKey + "?state=" + Constants.state),
        mode: LaunchMode.inAppBrowserView);

    // handle subsequent incoming links while app is running
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) _processUri(uri);
    }, onError: (err) {
      // handle error
    });
  }

  Future<void> _initInitialUri() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) _processUri(initialUri);
    } catch (e) {
      // handle error
    }
  }

  Future<void> _processUri(Uri uri) async {
    setState(() => _latestLink = uri.toString());
    // parse query parameters:
    final params = uri.queryParameters; // Map<String, String>
    var token = params['token'];
    // or get path segments:
    // final id = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;

    // Now use these params (navigate, store, etc.)
    // print('Deep link: $uri, token=$token, id=$id');













    //////??????for dev...
    if (Constants().isDevelop) token = '1111';

    if (token != null) {
      //Navigator.pop(context);
      Loading.open(context);
      var myRes = await GetLoginInfo().getData(token);
      Loading.close(context);

      if (myRes.statusCode == 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('loginInfo', myRes.data!);

        var mapLoginInfo = jsonDecode(myRes.data!);
        var myResBaseDef = await GetBaseDefinitions().getData(mapLoginInfo['token']);
        if (myResBaseDef.statusCode == 0) {
          prefs.setString('baseDefinitions', myResBaseDef.data!);

          ///Navigator.pop(context);///?????

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OfficerSelection() /*PollutantRegister(loginInfo: loginInfo,)*/),
          );
        }
      //   else {
      //     ShowModal(
      //             title: myResBaseDef.statusCode.toString(),
      //             content: myResBaseDef.errors.toString())
      //         .Message(context);
      //     controller.loadRequest(
      //         Uri.parse(Constants.loginPageUri + loginKey + "?state=" + Constants.state));
      //   }
      // } else {
      //   ShowModal(title: myRes.statusCode.toString(), content: myRes.errors.toString())
      //       .Message(context);
      //   controller.loadRequest(
      //       Uri.parse(Constants.loginPageUri + loginKey + "?state=" + Constants.state));
      }
    }









  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text(_latestLink ?? '...منتظر دریافت پاسخ از سامانه لاگین')));
  }
}
