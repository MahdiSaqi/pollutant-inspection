
import 'package:flutter/material.dart';

class Loading
{
  static open(BuildContext context)
  {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return Center(child: CircularProgressIndicator());
        });
  }
  static close(BuildContext context)
  {
    Navigator.pop(context);
  }

}