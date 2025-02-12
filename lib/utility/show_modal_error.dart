import 'package:flutter/material.dart';

class ShowModal {
  final String title, content;
  final VoidCallback? onOkPressed;

  ShowModal({
    this.title = '',
    this.content = '',
    this.onOkPressed,
  });

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
              if (onOkPressed != null)
                TextButton(
                  onPressed: () {onOkPressed!();},
                  child: Text('تایید'), // Text for the Ok button
                ),
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
