import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'form_field.dart';

class LSPlate extends StatefulWidget {
  // numbers are from left to right
  final TextEditingController twoDigit;
  final TextEditingController letter;
  final TextEditingController threeDigit;
  final TextEditingController iranDigit;
  final Color color;
  final bool enable;

//
  LSPlate({required this.twoDigit,
    required this.letter,
    required this.threeDigit,
    required this.iranDigit,
    required this.color,
    this.enable = true});

  @override
  _LSPlateState createState() => _LSPlateState();
}

class _LSPlateState extends State<LSPlate> {
  FocusNode letterFocus = FocusNode(),
      twoDigitFocus = FocusNode(),
      threeDigitFocus = FocusNode(),
      iranDigitFocus = FocusNode();

  // final GlobalKey _dropdownKey = GlobalKey();




  @override
  void initState() {
    super.initState();
    widget.threeDigit.addListener(() {
      if (widget.threeDigit.text.length==3) FocusScope.of(context).requestFocus(iranDigitFocus);
      // threeDigitFocus.requestFocus();
    });
    widget.letter.addListener(() {
      // FocusScope.of(context).requestFocus(threeDigitFocus);
      threeDigitFocus.requestFocus();
    });


  }

  showLetterPlate() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
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
                    children: <String>[
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
                    ].map((String alphabet) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.letter.text = alphabet;
                          });
                          Navigator.of(context).pop();
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
  }

  bool isDigit(String input) {
    return input.runes.every((int rune) {
      var character = String.fromCharCode(rune);
      return character.contains(RegExp(r'\d')); // Check if it's a digit
    });
  }

  @override
  Container build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 88,
          width: 300,

          // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: (widget.color == Colors.white &&
                    widget.letter != null &&
                    widget.letter.text != 'ع' &&
                    widget.letter.text != 'ت')
                    ? AssetImage("lib/assets/images/plate_modat.png")
                    : (widget.letter.text == 'ع')
                    ? AssetImage("lib/assets/images/plate.png")
                    : AssetImage("lib/assets/images/plate_taxi.png"),
              )),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  top: 20,
                  bottom: 20,
                  //right: 54,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Container(
                              margin: EdgeInsets.only(right: 7),
                              width: 45,
                              child: plateText(
                                ///---------------------------------------------------------2 digit
                                onTap: () {},
                                controller: widget.twoDigit,
                                maxLength: 2,
                                node: twoDigitFocus,
                                autoFocus: true,
                              )),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(right: 7),
                            width: 60,
                            height: 60,
                            // margin: EdgeInsets.only(right: 7),
                            color: (widget.letter != null &&
                                widget.letter.text != 'ع' &&
                                widget.letter.text != 'ت')
                                ? Colors.white
                                : (widget.letter.text == 'ع')
                                ? Colors.yellow[700]?.withOpacity(0.4)
                                : Colors.yellow,
                            child: plateText(

                              ///----------------------------------------------------------letter
                              //autoFocus: true,
                              keyboardType: TextInputType.none,
                              node: letterFocus,
                              maxLength: 1,
                              controller: widget.letter,
                              onTap: () async {
                                await showLetterPlate();
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                              margin: EdgeInsets.only(right: 14),
                              width: 60,
                              child: plateText(
                                ///------------------------------------------------------3 digit
                                // autoFocus: true,
                                  onTap: () {},
                                  controller: widget.threeDigit,
                                  maxLength: 3,
                                  node: threeDigitFocus)),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 13,
                  //width: 30,
                  bottom: 20,
                  child: Container(
                    width: 45,
                    child: plateText(
                      ///--------------------------------------------------------------iran digit
                      onTap: () {},
                      controller: widget.iranDigit,
                      maxLength: 2,
                      node: iranDigitFocus,
                      // autoFocus: false
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField plateText({required TextEditingController controller,
    required int maxLength,
    double fontSize = 27,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 0),
    required FocusNode node,
    bool autoFocus = false,
    required Function() onTap,
    TextInputType keyboardType = TextInputType.number}) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: fontSize),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.top,
      maxLength: maxLength,
      readOnly: (controller.text != null && !isDigit(controller.text) || widget.enable == false)
          ? true
          : false,
      //  enabled:
      //      (controller.text != 'ع' && widget.enable == false) ? false : true,
      // enabled: (controller.text=='ع' || DataModel.of(context).loadMap==false && widget.color!=Colors.white )? false:true,
      enableInteractiveSelection: false,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      autofocus: autoFocus,

      onChanged: (value) {
        if (value.length == maxLength) {
          if (node == twoDigitFocus) {
            showLetterPlate();
          }
          // FocusScope.of(context).nextFocus();

          // GestureDetector? detector =
          //     _dropdownKey.currentContext?.findAncestorWidgetOfExactType<GestureDetector>();
        }
      },

      //    onEditingComplete: () => FocusScope.of(context).nextFocus(),
      //  onEditingComplete: () {
      //    return node.nextFocus();
      // },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.09), width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          fillColor: (widget.color == Colors.white &&
              widget.letter != null &&
              widget.letter.text != 'ع' &&
              widget.letter.text != 'ت')
              ? widget.color
              : (widget.letter.text == 'ع')
              ? Colors.yellow[700]?.withOpacity(0.4)
              : Colors.yellow,
          //  fillColor: Colors.yellow[700].withOpacity(0.4),
          //.withOpacity(0.9),
          filled: true,
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.05), width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.2), width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          // enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: padding,
          hintStyle: TextStyle(color: Colors.black26)),
    );
  }
}
