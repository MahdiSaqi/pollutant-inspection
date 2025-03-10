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
  LSPlate(
      {required this.twoDigit,
      required this.letter,
      required this.threeDigit,
      required this.iranDigit,
      required this.color,
      this.enable = true});

  @override
  _LSPlateState createState() => _LSPlateState();
}

class _LSPlateState extends State<LSPlate> {
  // int number1;
  // int number2;
  // int number3;
  String alpha = '';
  FocusNode? focusNode;
  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    alpha = widget.letter.text;
    super.initState();
  }

  TextEditingController carModelController = TextEditingController(text: "");

  @override
  Container build(BuildContext context) {
    final node = FocusScope.of(context);

    return Container(
      child: Center(
        child: Container(
          height: 88,
          width: 300,

          // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
            image:
                (widget.color == Colors.white && widget.letter != null && widget.letter.text != 'ع')
                    ? AssetImage("lib/assets/images/plate_modat.png")
                    : AssetImage("lib/assets/images/plate.png"),
          )),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                // Positioned(
                //   left: 90,
                //   top: 20,
                //   child: Container(
                //     width: 45,
                //     color: Colors.yellow[700],//.withOpacity(0.9),
                //       padding: EdgeInsets.symmetric(horizontal: 3.5),
                //       child: DropdownButton<String>(
                //     value: alpha,
                //     elevation: 16,
                //     style: TextStyle(
                //         fontFamily: "Shabnam",
                //         fontSize: 23,
                //         color: Colors.black87),
                //     onChanged: (String newValue) {
                //       setState(() {
                //         widget.letter.text = newValue;
                //         alpha = newValue;
                //         return node.nextFocus();
                //       });
                //     },
                //     underline: Container(width: 45,),
                //     items: <String>[
                //       // 'ب',
                //       // 'ج',
                //       // 'د',
                //       // 'س',
                //       // 'ص',
                //       // 'ط',
                //       // 'ق',
                //       // 'ل',
                //       // 'م',
                //       // 'ن',
                //       // 'و',
                //       // 'ه',
                //       // 'ی',
                //       // 'ژ',
                //       // 'الف',
                //       'ع',
                //       // 'ش',
                //       // 'پ',
                //     ].map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //   )),
                // ),
                Positioned(
                  left: 40,
                  top: 30,
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
                                controller: widget.twoDigit,
                                maxLength: 2,
                                node: node,
                                autoFocus: true,
                              )),
                        ),
                        Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            // margin: EdgeInsets.only(right: 7),
                            color: (widget.letter != null && widget.letter.text == 'ع')
                                ? Colors.yellow[700]?.withOpacity(0.4)
                                : Colors.white,
                            child: TextFormField(
                              keyboardType: TextInputType.none,
                              controller: carModelController,
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        width: 500, // Set a width for the dialog
                                        height: 400, // Set a height for the dialog
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: ListView(
                                                children: <String>[
                                                  'الف',
                                                  'ب',
                                                  'پ',
                                                  'ت',
                                                  'ث',
                                                  'ج',
                                                  'چ',
                                                  'ح',
                                                  'خ',
                                                  'د',
                                                  'ذ',
                                                  'ر',
                                                  'ز',
                                                  'ژ',
                                                  'س',
                                                  'ش',
                                                  'ص',
                                                  'ط',
                                                  'ق',
                                                  'ک',
                                                  'گ',
                                                  'ل',
                                                  'م',
                                                  'ن',
                                                  'و',
                                                  'ه',
                                                  'ی'
                                                ].map((String alphabet) {
                                                  return ListTile(
                                                    title: Text(alphabet),
                                                    onTap: () {
                                                      setState(() {
                                                        carModelController.text =
                                                            alphabet; // Update the text controller with the selected alphabet
                                                        // pollutantRegisterModel.carModel = alphabet; // Assuming carModel is a string
                                                        // Perform any additional logic needed
                                                      });
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
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
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                              margin: EdgeInsets.only(right: 14),
                              width: 60,
                              child: plateText(
                                  controller: widget.threeDigit, maxLength: 3, node: node)),
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
                        controller: widget.iranDigit, maxLength: 2, node: node, autoFocus: false),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField plateText(
      {required TextEditingController controller,
      required int maxLength,
      double fontSize = 27,
      EdgeInsets padding = const EdgeInsets.symmetric(vertical: 0),
      required FocusNode node,
      bool autoFocus = false}) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: fontSize),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.top,
      maxLength: maxLength,
      readOnly: (controller.text != null && controller.text == 'ع' || widget.enable == false)
          ? true
          : false,
      //  enabled:
      //      (controller.text != 'ع' && widget.enable == false) ? false : true,
      // enabled: (controller.text=='ع' || DataModel.of(context).loadMap==false && widget.color!=Colors.white )? false:true,
      enableInteractiveSelection: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      autofocus: autoFocus,
      onChanged: (value) {
        // print('inaja 3');
        // print(value.toString());
        if (value.length == maxLength) {
          //   print('33333');
          FocusScope.of(context).nextFocus();
          //   if (value.length == 2 &&  widget.letter != null /*&&
          //       widget.letter.text == 'ع'*/)
          //     // FocusScope.of(context).nextFocus();
          //     // focusNode!.requestFocus();

          GestureDetector? detector =
              _dropdownKey.currentContext?.findAncestorWidgetOfExactType<GestureDetector>();
        }
      },

      //    onEditingComplete: () => FocusScope.of(context).nextFocus(),
      //  onEditingComplete: () {
      //    return node.nextFocus();
      // },
      decoration: new InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.09), width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          fillColor:
              (widget.color == Colors.white && widget.letter != null && widget.letter.text != 'ع')
                  ? widget.color
                  : Colors.yellow[700]?.withOpacity(0.4),
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
