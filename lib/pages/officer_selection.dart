import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pollutant_inspection/pages/landing_page.dart';
import 'package:pollutant_inspection/pages/pollutant_register.dart';

import 'package:pollutant_inspection/widgets/dropdown_3.dart';
import 'package:pollutant_inspection/utility/map_to_list.dart';
import 'package:pollutant_inspection/models/base_definitionDTO.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/SIMA_base_definitions.dart';

class OfficerSelection extends StatefulWidget {
  @override
  State<OfficerSelection> createState() => _OfficerSelectionState();
}

class _OfficerSelectionState extends State<OfficerSelection> {
  //const OfficerSelection({Key? key}) : super(key: key);
  List<BaseDefinitionDTO> officers = [
    BaseDefinitionDTO(id: "0", title: "عدم دریافت لیست"),
  ];

  TextEditingController officersController = TextEditingController(
    text: "0",
  );
  bool isButtonDisabled = true;

  dynamic _onChanged(dynamic selectedValue) async {
    // print("hasTech..."+hasTechnicalDiagnosisController.text);
    print("Selected Value: ${selectedValue['value']}");
    print("Selected id: ${selectedValue['id']}");
    print("Selected title: ${selectedValue['title']}");
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('officerName',selectedValue['title'].toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  _initialize() async {
    var prefs = await SharedPreferences.getInstance();
    var strBaseDef = prefs.getString('baseDefinitions');
    if (strBaseDef != null) {
      var baseDef = jsonDecode(strBaseDef);
      try {
        setState(() {
          officers = List<BaseDefinitionDTO>.from(
              baseDef['officers'].map((item) =>
                  BaseDefinitionDTO.fromJson(item)));
          isButtonDisabled = false;
        });
      }
      catch(e){ print(e);  }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DropdownList(
              key: GlobalKey(),
              title: "افسر شیفت",
              items: MapConvertor.MapToList(officers),
              //  MapToList(relationWithOwnerItems), //MapToList(loginInfo.officers),
              selected: officersController,
              onChanged: (selectedValue) {
                _onChanged(selectedValue);
                //pollutantRegisterModel.officerId=int.parse(selectedValue['id']);
              },
            ),
            ElevatedButton(
                onPressed: isButtonDisabled
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()));
                      },
                child: Row(
                  children: [Text('ورود'), Icon(Icons.clear)],
                ))
          ],
        ),
      ),
    );
  }
}
