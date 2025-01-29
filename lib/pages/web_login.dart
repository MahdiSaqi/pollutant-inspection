import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:pollutant_inspection/models/constants.dart';
import 'package:pollutant_inspection/pages/pollutant_register.dart';
import 'package:pollutant_inspection/server_utility/get_login_info.dart';
import 'package:pollutant_inspection/utility/loding.dart';
import 'package:pollutant_inspection/pages/officer_selection.dart';

import '../server_utility/get_base_definitions.dart';


class WebLogin extends StatelessWidget {
  String loginKey;
  WebLogin(this.loginKey);
  @override
  Widget build(BuildContext context) {
    print(Constants.loginPageUri
        +loginKey
        +"?state="
        +Constants.state
    );
    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
            Uri uri = Uri.parse(url);
            String? token = uri.queryParameters['t'];
            token = '1111';
            if(token != null)
            {

              //Navigator.pop(context);
              //TODO     مقداار توکن باید از رشته آدرس برگشتی استخراج شود
              Loading.open(context);
              var loginInfo=await GetLoginInfo().getData(token);
              Loading.close(context);

              if(loginInfo!=null)
              {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('loginInfo', jsonEncode(loginInfo));

                  var baseDef = await GetBaseDefinitions().getData(loginInfo.token);
                  prefs.setString('baseDefinitions', baseDef!);

                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OfficerSelection() /*PollutantRegister(loginInfo: loginInfo,)*/),
                  );
              }

            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
            Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          // onHttpAuthRequest: (HttpAuthRequest request) {
          //   openDialog(request);
          // },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          Constants.loginPageUri
          +loginKey
          +"?state="
          +Constants.state
      ));
    return WebViewWidget(controller: controller);
  }
}