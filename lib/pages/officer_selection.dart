import 'package:flutter/material.dart';
import 'package:pollutant_inspection/pages/pollutant_register.dart';

import 'package:pollutant_inspection/widgets/dropdown_3.dart';
import 'package:pollutant_inspection/utility/map_to_list.dart';
import 'package:pollutant_inspection/models/base_definitionDTO.dart';

import '../models/SIMA_base_definitions.dart';

class OfficerSelection extends StatelessWidget {
  //const OfficerSelection({Key? key}) : super(key: key);
  List<BaseDefinitionDTO> relationWithOwnerItems=[
    BaseDefinitionDTO(id: "0", title: "مالک"),
    BaseDefinitionDTO(id: "1", title: 'پیمانکار'),
    BaseDefinitionDTO(id: "2", title: 'راننده'),
    BaseDefinitionDTO(id: "3", title: 'وکالتی'),
    BaseDefinitionDTO(id: "4", title: 'قولنامه ای'),
    BaseDefinitionDTO(id: "5", title: 'همسر'),
    BaseDefinitionDTO(id: "6", title: 'فرزند'),
    BaseDefinitionDTO(id: "7", title: 'برادر'),
    BaseDefinitionDTO(id: "8", title: 'خواهر'),
    BaseDefinitionDTO(id: "9", title: 'پدر'),
    BaseDefinitionDTO(id: "10", title: 'مادر'),
    BaseDefinitionDTO(id: "11", title: 'فامیل وابسته'),
  ];

  TextEditingController  officersController=TextEditingController(text: "0",);
  dynamic _onChanged(dynamic selectedValue)
  {
    // print("hasTech..."+hasTechnicalDiagnosisController.text);
    print("Selected Value: ${selectedValue['value']}");
    print("Selected id: ${selectedValue['id']}");
    print("Selected title: ${selectedValue['title']}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DropdownList(key:GlobalKey(),
            title: "افسر شیفت",
            items: MapConvertor.MapToList(relationWithOwnerItems), //  MapToList(relationWithOwnerItems), //MapToList(loginInfo.officers),
            selected: officersController,
            onChanged: (selectedValue) {
              _onChanged(selectedValue);
              //pollutantRegisterModel.officerId=int.parse(selectedValue['id']);
            },
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PollutantRegister()));
              },
              child: Row(children: [Text('ورود'),Icon(Icons.clear) ],)
          )
        ],
      ),
    );

  }
}
