// import 'package:flutter/cupertino.dart';
// import 'dart:js';

import 'package:flutter/material.dart';

class MyFormField extends  StatelessWidget{
  MyFormField({required this.labelText,required this.controller,this.validator,this.keyboardType,this.maxLength,this.onTap});
  final String labelText;
  TextEditingController controller=TextEditingController();
  String? Function(String?)? validator;
  void Function()? onTap;
  TextInputType? keyboardType;
  int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        focusNode: FocusNode(),///for focus to next
        textInputAction: TextInputAction.next,///for focus to next
        onEditingComplete:() {
          // Move focus to the next field
          FocusScope.of(context).nextFocus();
        },
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gapPadding: 10.0,
          ),
          // icon: Icon(Icons.person),
          // hintTextDirection:TextDirection.rtl,
          labelStyle: TextStyle(decorationStyle: TextDecorationStyle.dashed),
          hintText: labelText,
          labelText:labelText,
        ),
        onSaved: (String? value) {
          // This optional block of code can be used to run
          // code when the user saves the form.
        },
        onTap: onTap,
        onChanged: (input){
          if(input.length==maxLength)
            {
              FocusScope.of(context).nextFocus();
            };
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,/*(String? value) {
          return (value != null && value.contains('@'))
              ? 'Do not use the @ char.'
              : null;
        },*/
      ),
    );
  }
}
