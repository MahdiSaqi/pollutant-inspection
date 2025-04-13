import 'dart:convert';

import 'dart:io' as dartIO;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:pollutant_inspection/enums/cars_pollutants.dart';
import 'package:pollutant_inspection/enums/fueling_type.dart';
import 'package:pollutant_inspection/enums/pollution_analyze_method.dart';
import 'package:pollutant_inspection/enums/recorded_document.dart';
import 'package:pollutant_inspection/enums/relation_with_owner.dart';
import 'package:pollutant_inspection/models/SIMA_login_info.dart';
import 'package:pollutant_inspection/models/constants.dart';
import 'package:pollutant_inspection/models/pollutant_register_model.dart';
import 'package:pollutant_inspection/server_utility/get_login_key.dart';
import 'package:pollutant_inspection/server_utility/send_pollutant_information.dart';
import 'package:pollutant_inspection/utility/get_current_location.dart';
import 'package:pollutant_inspection/utility/loding.dart';
import 'package:pollutant_inspection/utility/show_modal_error.dart';
import 'package:pollutant_inspection/widgets/button_style.dart';
import 'package:pollutant_inspection/widgets/camera.dart';
import 'package:pollutant_inspection/widgets/dropdown_2.dart';
import 'package:pollutant_inspection/widgets/dropdown_3.dart';
import 'package:pollutant_inspection/widgets/dropdown_enum.dart';
import 'package:pollutant_inspection/widgets/form_field.dart';
import 'package:pollutant_inspection/widgets/dropdown_field.dart';
import 'package:pollutant_inspection/widgets/lsplate2.dart';
import 'package:pollutant_inspection/utility/map_to_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/base_definitionDTO.dart';
import '../server_utility/get_plate_search.dart';

class PollutantRegisterForm extends StatefulWidget {
  // SIMALoginInfo loginInfo;
  // PollutantRegisterForm({required this.loginInfo});
  @override
  PollutantRegisterFormState createState() {
    return PollutantRegisterFormState(/*loginInfo: loginInfo*/);
  }
}

class PollutantRegisterFormState extends State<PollutantRegisterForm> {
  // region definitions
  var pollutantRegisterModel = PollutantRegisterModel();
  FocusNode nameFieldFocus = FocusNode(), familyFieldFocus = FocusNode();
  static const String noneSelection = 'بدون انتخاب';
  String _selectedDate = Jalali.now().toJalaliDateTime();
  dartIO.File? _base64Image;
  bool hasTech = false; //برای مشاهده یا عدم مشاهده مراکز معاینه فنی
  bool hasAnalyzer = false;
  bool needTechnicalDiagnosis = false;
  bool hasRecordedDocument = false;
  final ScrollController _scrollController = ScrollController();
  bool DualSelected = false;

  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  List<BaseDefinitionDTO> relationWithOwnerItems = [
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
  List<BaseDefinitionDTO> actionTypeItems = [
    BaseDefinitionDTO(id: '8', title: 'درخواست توقیف پلاک'),
    BaseDefinitionDTO(id: '9', title: 'اخذ مدرک'),
  ];
  List<BaseDefinitionDTO> recordedDocumentItems = [
    BaseDefinitionDTO(id: '0', title: 'گواهی نامه'),
    BaseDefinitionDTO(id: '1', title: 'کارت ملی'),
    BaseDefinitionDTO(id: '2', title: 'کارت خودرو'),
    BaseDefinitionDTO(id: '3', title: 'بیمه نامه'),
    BaseDefinitionDTO(id: '4', title: 'شناسنامه'),
    BaseDefinitionDTO(id: '5', title: 'جواز کسب'),
    BaseDefinitionDTO(id: '6', title: 'سند خودرو'),
    BaseDefinitionDTO(id: '7', title: 'کارت پایان خدمت'),
  ];

  List<BaseDefinitionDTO> districtItems = [
    BaseDefinitionDTO(id: '1', title: 'منطقه 1'),
    BaseDefinitionDTO(id: '2', title: 'منطقه 2'),
    BaseDefinitionDTO(id: '3', title: 'منطقه 3'),
    BaseDefinitionDTO(id: '4', title: 'منطقه 4'),
    BaseDefinitionDTO(id: '5', title: 'منطقه 5'),
    BaseDefinitionDTO(id: '6', title: 'منطقه 6'),
    BaseDefinitionDTO(id: '7', title: 'منطقه 7'),
    BaseDefinitionDTO(id: '8', title: 'منطقه 8'),
    BaseDefinitionDTO(id: '9', title: 'منطقه 9'),
    BaseDefinitionDTO(id: '10', title: 'منطقه 10'),
    BaseDefinitionDTO(id: '11', title: 'منطقه 11'),
    BaseDefinitionDTO(id: '12', title: 'منطقه 12'),
    BaseDefinitionDTO(id: '13', title: 'منطقه ثامن'),
    BaseDefinitionDTO(id: '14', title: 'خارج از شهر'),
  ];
  List<BaseDefinitionDTO> engineTypeItems = [
    BaseDefinitionDTO(id: '0', title: 'بنزین'),
    BaseDefinitionDTO(id: '1', title: 'گازوئیل'),
  ];
  List<BaseDefinitionDTO> fuelingTypeItems = [
    BaseDefinitionDTO(id: '0', title: 'انژکتور'),
    BaseDefinitionDTO(id: '1', title: 'کاربراتور'),
  ];
  List<BaseDefinitionDTO> hasTechnicalDiagnosisItems = [
    BaseDefinitionDTO(id: 'true', title: 'دارد'),
    BaseDefinitionDTO(id: 'false', title: 'ندارد'),
  ];
  List<BaseDefinitionDTO> analyzeMethodItems = [
    BaseDefinitionDTO(id: '0', title: 'مشاهده چشمی'),
    BaseDefinitionDTO(id: '1', title: 'دستگاه آنالایزر'),
  ];
  List<BaseDefinitionDTO> pollutantTypeItems = [
    BaseDefinitionDTO(id: '0', title: 'روغن سوزی'),
    BaseDefinitionDTO(id: '1', title: 'خام سوزی'),
  ];

  ///load from storage(sharedPreferences)
  // List<BaseDefinitionDTO> carTypes = [BaseDefinitionDTO(id: '0', title: 'عدم دریافت لیست')];
  List<BaseDefinitionDTO> petrolCarTypes = [BaseDefinitionDTO(id: '0', title: 'عدم دریافت لیست')];
  List<BaseDefinitionDTO> gasolineCarTypes = [BaseDefinitionDTO(id: '0', title: 'عدم دریافت لیست')];

  ///load from storage(sharedPreferences)
  List<BaseDefinitionDTO> technicalCenters = [BaseDefinitionDTO(id: '0', title: 'عدم دریافت لیست')];

  String officerName = "نام افسر انتخاب نشده است";

  TextEditingController
      //officersController = TextEditingController(text: "0",),
      relationWithOwnerController = TextEditingController(text: "0"),
      nameController = TextEditingController(),
      familyController = TextEditingController(),
      driverNationalCodeController = TextEditingController(),
      driverMobileController = TextEditingController(),
      driverDriveLicenseController = TextEditingController(),
      recordedDocumentController = TextEditingController(text: "0"),
      actionTypeController = TextEditingController(text: "0"),
      districtController = TextEditingController(text: "0"),
      driverAddressController = TextEditingController(),
      engineTypeController = TextEditingController(text: "0"),
      fuelingTypeController = TextEditingController(text: "0"),
      hasTechnicalDiagnosisController = TextEditingController(text: "0"),
      analyzeMethodController = TextEditingController(text: "0"),
      pollutantTypeController = TextEditingController(text: "0"),
      carTypesController = TextEditingController(text: "0"),
      carModelController = TextEditingController(text: ""),
      technicalCentersController = TextEditingController(text: "0"),
      //sourceCategoriesController = TextEditingController(text: "0"),
      dateController = TextEditingController(text: "0"),
      //plate controllers
      twoDigit = TextEditingController(text: ""),
      letter = TextEditingController(text: ""),
      threeDigit = TextEditingController(text: ""),
      iranDigit = TextEditingController(text: ""),
      //analyzer values
      O2Controller = TextEditingController(text: ""),
      LambdaController = TextEditingController(text: ""),
      COController = TextEditingController(text: ""),
      HCController = TextEditingController(text: ""),
      NOController = TextEditingController(text: ""),
      CO2Controller = TextEditingController(text: ""),
      OpacityController = TextEditingController(text: ""),
      KController = TextEditingController(text: "");

  // endregion definitions

  @override
  void initState() {
    // TODO: implement initState
    _initialize();
    super.initState();
  }

  _initialize() async {
    ///TODO دریافت آنلاین اطلاعات از سرور باید انجام شود
    var prefs = await SharedPreferences.getInstance();
    var strBaseDef = prefs.getString('baseDefinitions');
    if (strBaseDef != null) {
      var baseDef = jsonDecode(strBaseDef);

      ///officer
      //var prefs = await SharedPreferences.getInstance();
      var strOfficer = prefs.getString('officer');
      var officer = jsonDecode(strOfficer!);
      pollutantRegisterModel.officerId = int.parse(officer['id']);

      setState(() {
        petrolCarTypes = List<BaseDefinitionDTO>.from(
            baseDef['petrolCarTypes'].map((item) => BaseDefinitionDTO.fromJson(item)));
        gasolineCarTypes = List<BaseDefinitionDTO>.from(
            baseDef['gasolineCarTypes'].map((item) => BaseDefinitionDTO.fromJson(item)));

        technicalCenters = List<BaseDefinitionDTO>.from(
            baseDef['technicalCenters'].map((item) => BaseDefinitionDTO.fromJson(item)));
        officerName = officer['title'];
      });
    }
  }

  void handleImageSelected(dartIO.File? base64Image) {
    setState(() {
      _base64Image = base64Image;
    });
    // You can now use the base64 encoded image data here (e.g., display, store, send to server)
  }

  // List<Map<String, dynamic>> MapConvertor.MapToList(List<BaseDefinitionDTO> items)
  // {
  //   var res =  <Map<String,dynamic>>{};
  //   res.add({'value': '0', 'title': noneSelection, 'id': '-1'});
  //   var x = 1;
  //   for(int i=0;i<items.length;i++) {
  //     res.add( {'value': x.toString(), 'title': items[i].title, 'id': items[i].id});
  //     x++;
  //   }
  //   return res.toList();
  // }

  dynamic _onChanged(dynamic selectedValue) {
    // print("hasTech..."+hasTechnicalDiagnosisController.text);
    print("Selected Value: ${selectedValue['value']}");
    print("Selected id: ${selectedValue['id']}");
    print("Selected title: ${selectedValue['title']}");
  }

  bool isCorrectPlate() {
    if (twoDigit.text.isEmpty ||
            threeDigit.text.isEmpty ||
            iranDigit.text.isEmpty ||
            letter.text == "-" ||
            twoDigit.text.length != 2 || // Check for 2 characters
            threeDigit.text.length != 3 || // Check for 3 characters
            iranDigit.text.length != 2 // Check for 4 characters (Iranian format)
        ) {
      return false;
    } else
      return true;
  }

  void _fillForm(Map<String, dynamic> res) {
    print(res['notice']['id']);
    if (!res['registerIsValid']) {
      ShowModal(title: 'خطا', content: 'این پلاک اخیرا ثبت شده است و امکان ثبت وجود ندارد')
          .Message(context);
      return;
    }
    pollutantRegisterModel = PollutantRegisterModel.fromJson(res['notice']);

    setState(() {
      engineTypeController.text = "0";
      pollutantRegisterModel.engineType.toString();
      // fuelingTypeController.text = "0";
      carTypesController.text = "1"; //pollutantRegisterModel.carTypeId.toString();
      carModelController.text = pollutantRegisterModel.carModel.toString();
      nameController.text = pollutantRegisterModel.driverName;
      familyController.text = pollutantRegisterModel.driverFamily;
      driverNationalCodeController.text = pollutantRegisterModel.driverNationalCode;
      // relationWithOwnerController.text = "0";
      driverMobileController.text = pollutantRegisterModel.driverMobile;
      // analyzeMethodController.text = "0";

      // recordedDocumentController.text = "0";
      // hasTech = false;

      // hasTechnicalDiagnosisController.text = "0";

      // technicalCentersController.text = "0";

      // districtController.text = "0";
      // driverAddressController.clear();

      // hasAnalyzer = false;
    });
  }

  void _clearForm() {
    driverNationalCodeController.clear();
    nameController.clear();
    familyController.clear();
    driverMobileController.clear();
    driverAddressController.clear();
    driverDriveLicenseController.clear();
    carModelController.clear();
    twoDigit.clear();
    threeDigit.clear();
    iranDigit.clear();
    dateController.clear();
    DualSelected = false;
    _clearPollutantValues();

    setState(() {
      // officersController.text="0"; //چون در همه ثبت های آن لاگین افسر شیفت تغییر نمی کند
      districtController.text = "0";
      relationWithOwnerController.text = "0";
      recordedDocumentController.text = "0";
      carTypesController.text = "0";
      engineTypeController.text = "0";
      fuelingTypeController.text = "0";
      //sourceCategoriesController.text = "0";
      technicalCentersController.text = "0";
      analyzeMethodController.text = "0";
      hasTechnicalDiagnosisController.text = "0";
      letter.text = "-";
      hasTech = false;
      hasAnalyzer = false;
      _base64Image = null;
    });
    var tempOfficerID = pollutantRegisterModel.officerId;
    pollutantRegisterModel = PollutantRegisterModel();
    pollutantRegisterModel.officerId = tempOfficerID;
    _scrollController.jumpTo(0);
    // FocusScope.of(context).requestFocus(nameFieldFocus);

  }

  void _clearPollutantValues() {
    pollutantTypeController.text = "0";
    O2Controller.clear();
    LambdaController.clear();
    COController.clear();
    HCController.clear();
    NOController.clear();
    CO2Controller.clear();
    OpacityController.clear();
    KController.clear();
  }

  Future<void> _searchFunction() async {
    if (!isCorrectPlate()) {
      ShowModal(title: 'لطفا موارد زیر را رعایت کنید', content: 'پلاک را به درستی وارد کنید')
          .Message(context);
      return;
    }
    var prefs = await SharedPreferences.getInstance();
    String? strLoginInfo = prefs?.getString('loginInfo');
    if (strLoginInfo != null) {
      var loginInfo = jsonDecode(strLoginInfo);
      var myRes = await GetPlateSearch().getData(
          loginInfo['token'], twoDigit.text + letter.text + threeDigit.text + iranDigit.text);
      if (myRes.statusCode == 0) {
        setState(() {
          _fillForm(jsonDecode(myRes.data!));
        });
      } else {
        ShowModal(
          content: myRes.errors.toString(),
          title: myRes.statusCode.toString(),
        ).Message(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          // DropdownList(
          //   key: GlobalKey(),
          //   title: "افسر شیفت",
          //   items: MapConvertor.MapToList(relationWithOwnerItems),
          //   //MapConvertor.MapToList(loginInfo.officers),
          //   selected: officersController,
          //   onChanged: (selectedValue) {
          //     _onChanged(selectedValue);
          //     pollutantRegisterModel.officerId = int.parse(selectedValue['id']);
          //   },
          // ),
          Text("افسر شیفت : " + officerName),
          LSPlate(
            twoDigit: twoDigit,
            letter: letter,
            threeDigit: threeDigit,
            iranDigit: iranDigit,
            color: Colors.white,
            searchFunction: _searchFunction,
          ),
          ElevatedButton(
              onPressed: () async {
                if (!isCorrectPlate()) {
                  ShowModal(
                          title: 'لطفا موارد زیر را رعایت کنید',
                          content: 'پلاک را به درستی وارد کنید')
                      .Message(context);
                  return;
                }
                var prefs = await SharedPreferences.getInstance();
                String? strLoginInfo = prefs?.getString('loginInfo');
                if (strLoginInfo != null) {
                  var loginInfo = jsonDecode(strLoginInfo);
                  var myRes = await GetPlateSearch().getData(loginInfo['token'],
                      twoDigit.text + letter.text + threeDigit.text + iranDigit.text);
                  if (myRes.statusCode == 0) {
                    setState(() {
                      _fillForm(jsonDecode(myRes.data!));
                    });
                  } else {
                    ShowModal(
                      content: myRes.errors.toString(),
                      title: myRes.statusCode.toString(),
                    ).Message(context);
                  }
                }
              },
              child: Icon(Icons.search)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: DropdownList(
                  key: GlobalKey(),
                  title: "نوع موتور خودرو",
                  items: MapConvertor.MapToList(engineTypeItems),
                  selected: engineTypeController,
                  onChanged: (selectedValue) {
                    _onChanged(selectedValue);
                    setState(() {
                      _clearPollutantValues();
                      pollutantRegisterModel.engineType = int.parse(selectedValue['id']);
                      if (pollutantRegisterModel.engineType == -1) {
                        carTypesController.text = "0";
                      } else if (pollutantRegisterModel.engineType == 0) {
                        carTypesController.text = "0";
                      } else if (pollutantRegisterModel.engineType == 1) {
                        carTypesController.text = "0";
                      }
                    });
                  },
                ),
              ),
              Text('دوگانه'),
              Switch(
                  value: DualSelected,
                  onChanged: (bool value) {
                    setState(() {
                      DualSelected = value;
                    });
                    pollutantRegisterModel.isDual = value;
                  }),
            ],
          ),
          DropdownList(
            key: GlobalKey(),
            title: "نوع سوخت رسانی",
            items: MapConvertor.MapToList(fuelingTypeItems),
            selected: fuelingTypeController,
            onChanged: (selectedValue) {
              _onChanged(selectedValue);
              pollutantRegisterModel.fuelType = int.parse(selectedValue['id']);
            },
          ),
          DropdownList(
            enable: pollutantRegisterModel.engineType == -1 ? false : true,
            key: GlobalKey(),
            title: "نوع خودرو",
            items: pollutantRegisterModel.engineType == 0
                ? MapConvertor.MapToList(petrolCarTypes)
                : pollutantRegisterModel.engineType == 1
                    ? MapConvertor.MapToList(gasolineCarTypes)
                    : MapConvertor.MapToList(
                        [BaseDefinitionDTO(id: '0', title: 'عدم دریافت لیست')]),
            //MapConvertor.MapToList(loginInfo.carTypes),
            selected: carTypesController,
            onChanged: (selectedValue) {
              _onChanged(selectedValue);
              pollutantRegisterModel.carTypeId = int.parse(selectedValue['id']);
            },
          ),

          MyFormField(
            labelText: 'مدل خودرو',
            keyboardType: TextInputType.none,
            controller: carModelController,
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: YearPicker(
                        firstDate: DateTime(1300),
                        lastDate: DateTime(Jalali.now().year + 1),
                        selectedDate: DateTime(Jalali.now().year - 4),
                        onChanged: (DateTime selectedDate) {
                          setState(() {
                            carModelController.text = selectedDate.year.toString();
                            pollutantRegisterModel.carModel = selectedDate.year;
                            if (selectedDate.year < (Jalali.now().year - 5))
                              needTechnicalDiagnosis = true;
                            else
                              needTechnicalDiagnosis = false;

                            // Return the selected year
                          });
                          Navigator.of(context).pop(selectedDate.year);
                        },
                      ),
                    );
                  });
            },
          ),

          MyFormField(
            selfFocusName: nameFieldFocus,
            nextFocusName: familyFieldFocus,
            labelText: 'نام راننده',
            controller: nameController,
          ),

          MyFormField(
            selfFocusName: familyFieldFocus,
            labelText: 'نام خانوادگی راننده',
            controller: familyController,
          ),

          MyFormField(
            labelText: 'کد ملی راننده',
            controller: driverNationalCodeController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: (String? value) {
              if (value!.isEmpty || value.length != 10 || !value.contains(RegExp(r'^[0-9]')))
                return 'کد ملی  به درستی وارد شود';
            },
          ),
          DropdownList(
            key: GlobalKey(),
            title: "نسبت با مالک",
            // items: relationWithOwnerItems,
            items: MapConvertor.MapToList(relationWithOwnerItems),
            selected: relationWithOwnerController,
            onChanged: (selectedValue) {
              _onChanged(selectedValue);
              pollutantRegisterModel.relationWithOwner = int.parse(selectedValue['id']);
            },
          ),

          MyFormField(
            labelText: 'تلفن همراه',
            controller: driverMobileController,
            keyboardType: TextInputType.number,
            maxLength: 11,
          ),
          // MyFormField(
          //   labelText: 'شماره گواهی نامه',
          //   controller: driverDriveLicenseController,
          // ),
          DropdownList(
            key: GlobalKey(),
            title: "روش سنجش آلایندگی",
            items: MapConvertor.MapToList(analyzeMethodItems),
            selected: analyzeMethodController,
            onChanged: (selectedValue) {
              _onChanged(selectedValue);
              _clearPollutantValues();
              setState(() {
                if (selectedValue['value'] == "2")
                  hasAnalyzer = true;
                else
                  hasAnalyzer = false;
              });
              pollutantRegisterModel.pollutionAnalyzeMethod = int.parse(selectedValue['id']);
            },
          ),
          if (analyzeMethodController.text != "0" && !hasAnalyzer)
            DropdownList(
              key: GlobalKey(),
              title: "نوع آلایندگی",
              items: MapConvertor.MapToList(pollutantTypeItems),
              selected: pollutantTypeController,
              onChanged: (selectedValue) {
                _onChanged(selectedValue);
                setState(() {
                  ///TODO -------------------
                });
                pollutantRegisterModel.pollutantType = int.parse(selectedValue['id']);
              },
            ),

          if (pollutantRegisterModel.engineType == 0 && hasAnalyzer)
            MyFormField(
              labelText: 'اکسیژن(O2)',
              controller: O2Controller,
              keyboardType: TextInputType.number,
            ),
          if (pollutantRegisterModel.engineType == 0 && hasAnalyzer)
            MyFormField(
              labelText: 'لاندا(lambda)',
              controller: LambdaController,
              keyboardType: TextInputType.number,
            ),
          if (pollutantRegisterModel.engineType == 0 && hasAnalyzer)
            MyFormField(
              labelText: 'مونوکسیدکربن(CO)',
              controller: COController,
              keyboardType: TextInputType.number,
            ),
          if (pollutantRegisterModel.engineType == 0 && hasAnalyzer)
            MyFormField(
              labelText: 'هیدروکربن های نسوخته(HC)',
              controller: HCController,
              keyboardType: TextInputType.number,
            ),
          if (pollutantRegisterModel.engineType == 0 && hasAnalyzer)
            MyFormField(
              labelText: 'مونوکسید نیتروژن(NO)',
              controller: NOController,
              keyboardType: TextInputType.number,
            ),
          if (pollutantRegisterModel.engineType == 0 && hasAnalyzer)
            MyFormField(
              labelText: 'دی اکسیدکربن(CO2)',
              controller: CO2Controller,
              keyboardType: TextInputType.number,
            ),
          if (pollutantRegisterModel.engineType == 1 && hasAnalyzer)
            MyFormField(
              labelText: 'کدورت(Opacity)',
              controller: OpacityController,
              keyboardType: TextInputType.number,
            ),
          if (pollutantRegisterModel.engineType == 1 && hasAnalyzer)
            MyFormField(
              labelText: 'ضریب جذب(K)',
              controller: KController,
              keyboardType: TextInputType.number,
            ),

          DropdownList(
            key: GlobalKey(),
            title: "نوع اعمال قانون",
            items: MapConvertor.MapToList(actionTypeItems),
            selected: actionTypeController,
            onChanged: (selectedValue) {
              _onChanged(selectedValue);
              int id = int.parse(selectedValue['id']);
              if (id == 8)
                setState(() {
                  pollutantRegisterModel.recordedDocument = id;
                  hasRecordedDocument = false;
                });
              else
                setState(() {
                  pollutantRegisterModel.recordedDocument = -1;
                  recordedDocumentController.text = "0";
                  hasRecordedDocument = true;
                });
            },
          ),

          if (hasRecordedDocument)
            DropdownList(
              key: GlobalKey(),
              title: "مدرک ضبط شده",
              items: MapConvertor.MapToList(recordedDocumentItems),
              selected: recordedDocumentController,
              onChanged: (selectedValue) {
                _onChanged(selectedValue);
                pollutantRegisterModel.recordedDocument = int.parse(selectedValue['id']);
              },
            ),

          if (needTechnicalDiagnosis)
            DropdownList(
              key: GlobalKey(),
              title: "داشتن معاینه فنی",
              items: MapConvertor.MapToList(hasTechnicalDiagnosisItems),
              selected: hasTechnicalDiagnosisController,
              onChanged: (selectedValue) {
                _onChanged(selectedValue);
                setState(() {
                  if (selectedValue['value'] == "1")
                    hasTech = true;
                  else
                    hasTech = false;
                });
                if (selectedValue['id'] != null)
                  pollutantRegisterModel.hasTechnicalDiagnosis = bool.parse(selectedValue['id']);
                else
                  pollutantRegisterModel.hasTechnicalDiagnosis = false;
              },
            )
          else
            Text('معاینه فنی نیاز ندارد'),
          if (needTechnicalDiagnosis && hasTech)
            MyFormField(
              keyboardType: TextInputType.none,
              labelText: "تاریخ اخذ معاینه فنی",
              controller: dateController,
              onTap: () async {
                Jalali? picked = await showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),
                    firstDate: Jalali(1400, 1),
                    lastDate: Jalali.now(),
                    //Jalali(1450, 9),
                    initialEntryMode: PDatePickerEntryMode.calendarOnly,
                    initialDatePickerMode: PDatePickerMode.year,
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          dialogTheme: const DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    });

                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    dateController.text = picked.formatCompactDate();
                    pollutantRegisterModel.technicalDiagnosisDateTime =
                        picked.toDateTime().toString();
                    print(picked.toDateTime());
                    print(pollutantRegisterModel.technicalDiagnosisDateTime);
                  });
                }
              },
            ),
          if (needTechnicalDiagnosis && hasTech)
            DropdownList(
              key: GlobalKey(),
              title: "مرکز معاینه فنی",
              items: MapConvertor.MapToList(technicalCenters),
              //MapConvertor.MapToList(loginInfo.technicalCenters),
              selected: technicalCentersController,
              onChanged: (selectedValue) {
                _onChanged(selectedValue);
                pollutantRegisterModel.technicalDiagnosisCenterId = int.parse(selectedValue['id']);
              },
            ),

          DropdownList(
            key: GlobalKey(),
            title: "منطقه شهری محل سکونت",
            items: MapConvertor.MapToList(districtItems),
            selected: districtController,
            onChanged: (selectedValue) {
              _onChanged(selectedValue);
              pollutantRegisterModel.cityZone = int.parse(selectedValue['id']);
            },
          ),

          MyFormField(
            labelText: 'نشانی',
            controller: driverAddressController,
          ),


          if (_base64Image != null)
            Container(
              // child: Text(
              //   'تصویر مستند',
              //   style: TextStyle(color: Colors.white),
              // ),
              // height: 300.0,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.75,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: FileImage(_base64Image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (_base64Image != null) SizedBox(width: 100.0),
          PictureForm(
            // labelText: 'تصویر مستند',
            onImageSelected: handleImageSelected,
          ),

          // DropDownField(),
          // DropDown2(),
          // DropdownEnum(),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
            child: ElevatedButton.icon(
              ///دکمه صدور اخطار
              icon: Icon(Icons.car_crash),

              style: MyButtonStyle.style(context, Colors.red),
              onPressed: () async {
                String strErrors = "";

                if (isCorrectPlate())
                  pollutantRegisterModel.carPlate =
                      twoDigit.text + letter.text + threeDigit.text + iranDigit.text;
                else
                  strErrors += 'پلاک را به درستی وارد کنید' + '\n';

                if (nameController.text == "" || familyController.text == "")
                  strErrors += 'نام یا نام خانوادگی راننده وارد نشده است' + '\n';
                else {
                  pollutantRegisterModel.driverName = nameController.text;
                  pollutantRegisterModel.driverFamily = familyController.text;
                }

                if (driverNationalCodeController.text.length == 10)
                  pollutantRegisterModel.driverNationalCode = driverNationalCodeController.text;
                else
                  strErrors += 'کد ملی باید 10 رقم باشد' + '\n';

                if (driverMobileController.text.length == 11)
                  pollutantRegisterModel.driverMobile = driverMobileController.text;
                else
                  strErrors += 'تلفن همراه باید 11 رقم باشد' + '\n';

                if (analyzeMethodController.text == "2" &&
                        (pollutantRegisterModel.engineType == 0 &&
                            (O2Controller.text.isEmpty ||
                                LambdaController.text.isEmpty ||
                                COController.text.isEmpty ||
                                HCController.text.isEmpty ||
                                NOController.text.isEmpty ||
                                CO2Controller.text.isEmpty)) ||
                    (pollutantRegisterModel.engineType == 1 &&
                        (OpacityController.text.isEmpty || KController.text.isEmpty)))
                  strErrors += 'مقادیر دستگاه آنالایزر وارد نشده است' + '\n';

                if (carModelController.text == "") {
                  strErrors += 'مدل خودرو وارد نشده است' + '\n';
                } else {
                  pollutantRegisterModel.carModel = int.parse(carModelController.text);
                }

                if (needTechnicalDiagnosis && hasTech && dateController.text.isEmpty)
                  strErrors += 'تاریخ اخذ معاینه فنی وارد نشده است' + '\n';

                if (driverAddressController.text == "")
                  strErrors += 'نشانی وارد نشده است' + '\n';
                else
                  pollutantRegisterModel.driverAddress = driverAddressController.text;

                //convert File To base64 image string
                if (_base64Image == null) {
                  strErrors += 'عکس گرفته نشده است' + '\n';
                } else {
                  final bytes = await _base64Image!.readAsBytes();
                  pollutantRegisterModel.photo = base64Encode(bytes);
                }
                if (engineTypeController.text == "0" ||
                    fuelingTypeController.text == "0" ||
                    carTypesController.text == "0" ||
                    relationWithOwnerController.text == "0" ||
                    analyzeMethodController.text == "0" ||
                    (analyzeMethodController.text == "1" && pollutantTypeController.text == "0") ||
                    actionTypeController.text == "0" ||
                    (actionTypeController.text == "2" && recordedDocumentController.text == "0") ||
                    (needTechnicalDiagnosis && hasTechnicalDiagnosisController.text == "0") ||
                    (hasTech && technicalCentersController.text == "0") ||
                    districtController.text == "0")
                  strErrors += 'گزینه های انتخاب نشده را انتخاب کنید' + '\n';

                if (strErrors.length > 0) {
                  ShowModal(title: 'خطا', content: strErrors).Message(context);
                  return;
                }

                ///location checker and get lat lng
                Loading.open(context);
                var res = await Location().getCurrentLocation();
                Loading.close(context);
                if (res.statusCode != 0) {
                  ShowModal(content: res.errors.toString(), title: 'خطا').Message(context);
                  return;
                } else {
                  var positionData = jsonDecode(res.data!);
                  pollutantRegisterModel.lat = positionData['lat'];
                  pollutantRegisterModel.lng = positionData['lng'];
                }

                pollutantRegisterModel.pollutantsValue = [];
                if (O2Controller.text.isNotEmpty)
                  pollutantRegisterModel.pollutantsValue.add(PollutantValue(
                      pollutant: CarsPollutants.O2, value: double.parse(O2Controller.text)));
                if (LambdaController.text.isNotEmpty)
                  pollutantRegisterModel.pollutantsValue.add(PollutantValue(
                      pollutant: CarsPollutants.Lambda,
                      value: double.parse(LambdaController.text)));
                if (COController.text.isNotEmpty)
                  pollutantRegisterModel.pollutantsValue.add(PollutantValue(
                      pollutant: CarsPollutants.CO, value: double.parse(COController.text)));
                if (HCController.text.isNotEmpty)
                  pollutantRegisterModel.pollutantsValue.add(PollutantValue(
                      pollutant: CarsPollutants.HC, value: double.parse(HCController.text)));
                if (NOController.text.isNotEmpty)
                  pollutantRegisterModel.pollutantsValue.add(PollutantValue(
                      pollutant: CarsPollutants.NO, value: double.parse(NOController.text)));
                if (CO2Controller.text.isNotEmpty)
                  pollutantRegisterModel.pollutantsValue.add(PollutantValue(
                      pollutant: CarsPollutants.CO2, value: double.parse(CO2Controller.text)));
                if (OpacityController.text.isNotEmpty)
                  pollutantRegisterModel.pollutantsValue.add(PollutantValue(
                      pollutant: CarsPollutants.Opacity,
                      value: double.parse(OpacityController.text)));
                if (KController.text.isNotEmpty)
                  pollutantRegisterModel.pollutantsValue.add(PollutantValue(
                      pollutant: CarsPollutants.K, value: double.parse(KController.text)));

                ShowModal(
                    title: 'اطلاعات زیر ثبت شود؟',
                    content: "شماره پلاک: " +
                        pollutantRegisterModel.carPlate
                            .substring(0, pollutantRegisterModel.carPlate.length - 2) +
                        "ایران" +
                        pollutantRegisterModel.carPlate
                            .substring(pollutantRegisterModel.carPlate.length - 2) +
                        "\n" +
                        "شماره همراه: " +
                        pollutantRegisterModel.driverMobile,
                    okButton: () async {
                      try {
                        Navigator.pop(context);
                        Loading.open(context);
                        var res = await PollutantInformation().send(pollutantRegisterModel);
                        Loading.close(context);

                        if (res.statusCode == 0) {
                          ShowModal(title: 'ثبت شد', content: 'اخطار با موفقیت صادر شد')
                              .Message(context);
                          _clearForm();
                        } else
                          ShowModal(
                                  title: res.statusCode.toString(), content: res.errors.toString())
                              .Message(context);
                        // if (res != null && res.statusCode == 200) {
                        //   var jsonRes = jsonDecode(res.body);
                        //   if (jsonRes['statusCode'] == 0) {
                        //     //TODO print
                        //     print(jsonRes['body']);
                        //     ShowModal(title: 'ثبت شد', content: 'اخطار با موفقیت صادر شد.')
                        //         .Message(context);
                        //     _clearForm();
                        //   } else {
                        //     print(jsonRes);
                        //     print(jsonRes['errors']);
                        //     ShowModal(
                        //       content: 'لطفا موارد زیر را رعایت کنید',
                        //       title: jsonRes['errors'].toString(),
                        //     ).Message(context);
                        //   }
                        // } else {
                        //   ShowModal(title: 'خطای ارتباطی', content: res!.statusCode.toString())
                        //       .Message(context);
                        // }
                      } catch (e) {
                        ShowModal(
                          content: 'خطا',
                          title: e.toString(),
                        ).Message(context);
                      }
                    }).Message(context);
              },

              ///on pressed
              label: Text("   صدور اخطار  "),
            ),
          ),
          // SizedBox(
          //   width: 40,
          // ),
          ElevatedButton.icon(
            style: MyButtonStyle.style(context, Colors.blueGrey),
            // style: ButtonStyle(
            //     backgroundColor: MaterialStatePropertyAll(Colors.red),
            //     foregroundColor: MaterialStatePropertyAll(Colors.white),
            //     fixedSize: MaterialStateProperty.all(Size(50, 50))),

            onPressed: () {
              ShowModal(
                  title: Constants.clearForm,
                  content: 'از پاک کردن فرم اطمینان دارید؟',
                  okButton: () {
                    _clearForm();
                    Navigator.pop(context);
                  }).Message(context);
            },
            label: Text(Constants.clearForm),
            icon: Icon(Icons.clear),
          ),
          SizedBox(
            height: 50,
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [Text('بازگشت به صفحه اصلی'), Icon(Icons.keyboard_return)],
          //     )
          // )
        ],
      ),
    );
  }
}
