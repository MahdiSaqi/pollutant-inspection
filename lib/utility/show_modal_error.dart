import 'package:flutter/material.dart';
import 'package:pollutant_inspection/widgets/button_style.dart';

class ShowModal {
  final String title, content;
  final VoidCallback? okButton;

  ShowModal({
    this.title = '',
    this.content = '',
    this.okButton,
  });

  void Message(BuildContext _context) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            // backgroundColor: Colors.white.withOpacity(0.5),
            title: Text(this.title),
            content: Text(this.content),
            actions: [
              if (okButton != null)
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    okButton!();
                  },
                  child: Icon(Icons.check),
                ), // Text for the Ok button
              CloseButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)),
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
