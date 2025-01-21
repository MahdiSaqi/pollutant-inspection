
import 'package:flutter/material.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({Key? key}) : super(key: key);

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  final List<String> options = ['گزینه 1', 'گزینه 2', 'گزینه 3'];
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedOption,
      decoration: InputDecoration(
        labelText: 'Select an Option',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gapPadding: 10.0,
        ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedOption = newValue;
        });
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,textDirection: TextDirection.rtl, textAlign: TextAlign.right,),
        );
      }).toList(),
    );}
}
