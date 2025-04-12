

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pollutant_inspection/utility/map_to_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginedUser extends StatefulWidget {
  const LoginedUser({Key? key}) : super(key: key);
  @override
  State<LoginedUser> createState() => _LoginedUserState();



}

class _LoginedUserState extends State<LoginedUser> {
  String userName="";

  @override
  initState(){
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async{
    var prefs=await SharedPreferences.getInstance();
    var loginInfo=await prefs.getString('loginInfo');
    var mappedLoginInfo=jsonDecode(loginInfo!);
    setState(() {
      userName = mappedLoginInfo['fullName'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(20, 0, 255, 0),
      child: Text("کاربر : " + userName,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(
          // color: Colors.deepPurple,
          fontSize: 16,
        ),),
    );
  }
}
