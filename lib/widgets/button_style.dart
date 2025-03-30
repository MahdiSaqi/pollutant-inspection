import 'package:flutter/material.dart';

class MyButtonStyle {
  static ButtonStyle style(BuildContext context,Color backColor) {
    return ButtonStyle(
      // Set a fixed size percentage of the screen size
      fixedSize: MaterialStateProperty.all(
        Size(MediaQuery.of(context).size.width * 0.75, 60), // 75% width and fixed height
      ),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      // padding: MaterialStatePropertyAll(EdgeInsets.all(MediaQuery.of(context).size.height * 0.03))
      backgroundColor: MaterialStateProperty.all(backColor), // Customize your button color here
      // textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)), // Customize text style
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      )),
    );
  }
}
