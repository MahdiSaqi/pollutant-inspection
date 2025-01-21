import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'form_field.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(body: new PersianDatePicker(key: super.key, title: 'دیت تایم پیکر فارسی')),
    );
  }
}

class PersianDatePicker extends StatefulWidget {
  PersianDatePicker({super.key, required this.title});
  final String title;
  @override
  _PersianDatePickerState createState() => new _PersianDatePickerState();
}

class _PersianDatePickerState extends State<PersianDatePicker> {
  String label = '';
  String _selectedDate = Jalali.now().toJalaliDateTime();
  var dateController=TextEditingController();

  @override
  void initState() {
    super.initState();
    label = 'انتخاب تاریخ زمان';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(height: 300,),
              MyFormField(
                keyboardType: TextInputType.none,
                labelText: "تاریخ اخذ معاینه",
                controller: dateController,
                onTap: ()async{
                  Jalali? picked = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1400, 1),
                      lastDate: Jalali.now(),//Jalali(1450, 9),
                      initialEntryMode: PDatePickerEntryMode.calendarOnly,
                      initialDatePickerMode: PDatePickerMode.year,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            dialogTheme: const DialogTheme(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(0)),
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      });

                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      dateController.text = picked.formatCompactDate();

                    });
                  }

                },
              ),

              Text(label),
            ],
          ),
        );
  }
}