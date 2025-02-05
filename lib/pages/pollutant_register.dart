
// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pollutant_inspection/models/SIMA_login_info.dart';
import 'package:pollutant_inspection/widgets/pollutant_register_form.dart';

class PollutantRegister extends StatelessWidget
{
  // SIMALoginInfo loginInfo;
  // PollutantRegister({required this.loginInfo});
  @override
  Widget build(BuildContext context)
  {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align title to the right
            children: [
              Text('صدور اخطار خودروی آلاینده'),
            ],
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
              child: PollutantRegisterForm()
          )
        ),
      ),
      canPop: false,
    );
  }
}