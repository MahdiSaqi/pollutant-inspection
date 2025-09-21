import 'package:flutter/material.dart';

class ShowModalWithSelector{
  String selectedItem='';
  Future<String> Show(BuildContext _context, List<String> items) async {
    await showDialog(
      context: _context,
      builder: (BuildContext _context) {
        return Dialog(
          child: Container(
            width: 300, // Set a width for the dialog
            height: 400, // Set a height for the dialog
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text(
                //     'Select an Alphabet',
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 5,
                    semanticChildCount: 5,
                    // Number of columns in the grid
                    children: /*<String>[
                      'ب',
                      'ج',
                      'د',
                      'س',
                      'ص',
                      'ط',
                      'ق',
                      'ل',
                      'م',
                      'ن',
                      'و',
                      'ه',
                      'ی',
                      'ژ',
                      'الف',
                      'ث',
                      'پ',
                      'ش',
                      'ع',
                      'ت'
                    ]*/items.map((String alphabet) {
                      return GestureDetector(
                        onTap: () {
                          selectedItem = alphabet;
                          Navigator.of(_context).pop();

                        },
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          // Margin around each card
                          child: Center(
                            child: Text(
                              alphabet,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return selectedItem;
  }

}

