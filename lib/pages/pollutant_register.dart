// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pollutant_inspection/models/SIMA_login_info.dart';
import 'package:pollutant_inspection/utility/show_modal_error.dart';
import 'package:pollutant_inspection/widgets/pollutant_register_form.dart';

class PollutantRegister extends StatelessWidget {
  // SIMALoginInfo loginInfo;
  // PollutantRegister({required this.loginInfo});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool invoked) async {
        ShowModal(
            title: 'برگشت به صفحه اصلی',
            content: 'از برگشت به صفحه اصلی اطمینان دارید',
            onOkPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            }).Message(context);
      },
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false, ///back without mobile back button
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align title to the right
            children: [
              Text('صدور اخطار خودروی آلاینده'),
            ],
          ),
        ),
        body: Directionality(textDirection: TextDirection.rtl, child: PollutantRegisterForm()),
      ),
    );
  }
}
