
import 'package:flutter/material.dart';

class ShowModal{
  final String title,content;
  ShowModal({this.title='',this.content=''});
  void Message(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.5),
            title: Text(this.title),
            content: Text(this.content),
            actions: [
              CloseButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              )
              // cancelButton,
              // continueButton,
            ],
          ),
        );
      },
    );
  }

}