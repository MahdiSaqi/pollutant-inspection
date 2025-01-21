import 'package:flutter/material.dart';

class DropdownList extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final TextEditingController selected;
  final EdgeInsets padding;
  final Function(dynamic selectedValue) onChanged;
  final bool enable;
  // final String field;

  const DropdownList({
    required this.items,
    required this.title,
    // required this.field,
    required this.selected,
    // this.selected,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    required this.onChanged,
    this.enable=true,
    required Key key,
  }) : super(key: key);

  @override
  _DropdownListState createState() => _DropdownListState();
}

/// This is the private State class that goes with DropdownList.
class _DropdownListState extends State<DropdownList> {
  late Map<String, dynamic>? selectedValue;

  @override
  void initState() {
    selectedValue=widget.items[int.parse(widget.selected.text)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(15.0),
      //padding: widget.padding,
      padding:const EdgeInsets.all(15.0),

      //  padding: const EdgeInsets.only(right: 20),

      child: InputDecorator(
        decoration: InputDecoration(
          enabledBorder:  OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.black12, width: 1.0),
          ),
          labelText: widget.title,
          fillColor: Color(0xffFFFAFA),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.05))),
          filled: true,
          contentPadding:
          EdgeInsets.only(bottom: 10.0, left: 10.0, right: 14.0),
        ),
        child: DropdownButton<Map<String, dynamic>>(
          value: selectedValue,
          icon: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.arrow_drop_down_outlined),
          ),
          iconSize: 34,
          isExpanded: true,
          elevation: 1,
          style: TextStyle(color: Colors.black54),
          underline: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: 1,
              color: Color(0xffFFFAFA), //.grey.withOpacity(0.5),
            ),
          ),
          onChanged: (Map<String, dynamic>? newValue) {

            setState(() {
              FocusScope.of(context).requestFocus(FocusNode());
              selectedValue = newValue;
              widget.selected.text = newValue?['value'];
              //  widget.selected.text = newValue?[widget.field];


              if(widget.onChanged != null)
                widget.onChanged(selectedValue);
            });
          },
          items: (widget.enable) ?widget.items.map<DropdownMenuItem<Map<String, dynamic>>>(
                  (Map<String, dynamic> value) {

                //return DropdownMenuItem<Map<String, dynamic>>(
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: value,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      value['title'],
                      maxLines: 10,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontFamily: "B Yekan",),
                      textAlign: TextAlign.right,
                    ),
                  ),
                );
              }).toList():null,
        ),
      ),
    );
  }
}
