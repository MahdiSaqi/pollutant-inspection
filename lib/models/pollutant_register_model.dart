// // import 'dart:ffi';
//
// import 'package:pollutant_inspection/enums/cars_pollutants.dart';
// import 'package:pollutant_inspection/utility/map_to_list.dart';
//
// class PollutantValue{
//   CarsPollutants? pollutant ;
//   double? value ;
//   PollutantValue({this.pollutant,this.value});
// }
//
// class PollutantRegisterModel {
//   // public RecordedDocument recordedDocument { get; set; }
//   //RecordedDocument recordedDocument=RecordedDocument.CarCard;
//   int recordedDocument = -1;
//
//   //int actionType=0;
//   // public string? recordedDocumentDescription { get; set; }
//   String? recordedDocumentDescription;
//
//   // public RelationWithOwner relationWithOwner { get; set; }
//   //RelationWithOwner relationWithOwner=RelationWithOwner.Owner;
//   int relationWithOwner = -1;
//
//   // [Required(ErrorMessage ="پلاک وارد نشده است")]
//   // public string carPlate { get; set; }
//   String carPlate = "";
//
//   // [Required(ErrorMessage ="نام مالک وارد نشده است")]
//   // public string ownerName { get; set; }
//   String driverName = "";
//
//   // [Required(ErrorMessage ="نام خانوادگی مالک وارد نشده است")]
//   // public string ownerFamily { get; set; }
//   String driverFamily = "";
//
//   // [Required(ErrorMessage ="شماره تلفن مالک وارد نشده است")]
//   // public string ownerMobile { get; set; }
//   String driverMobile = "";
//
//   // [Required(ErrorMessage ="کدملی مالک وارد نشده است")]
//   // public string ownerNationalCode { get; set; }
//   String driverNationalCode = "";
//
//   // [Required(ErrorMessage ="آدرس مالک وارد نشده است")]
//   // public string ownerAddress { get; set; }
//   String driverAddress = "";
//
//   // [Required(ErrorMessage ="شماره گواهینامه مالک وارد نشده است")]
//   // public string ownerDriveLicence { get; set; }
//   String driverDriveLicence = "";
//
//   // [Required(ErrorMessage ="نوع خودرو وارد نشده است")]
//   // public uint? carTypeId { get; set; }
//   int carTypeId = 0;
//
//   //
//   // /// <summary>
//   // /// سال ساخت
//   // /// </summary>
//   // public short carModel { get; set; }
//   int carModel = 0;
//
//   // /// <summary>
//   // /// طبقه بندی منبع
//   // /// </summary>
//   // [Required(ErrorMessage ="نوع منبع خودرو وارد نشده است")]
//   // public uint? sourceCategoryId { get; set; }
//   //int? sourceCategoryId;
//   // public FuelType fuel { get; set; }
//   //FuelType fuel=FuelType.Petrol;
//   int engineType = -1;
//
//   // /// <summary>
//   // /// نوع سوخت رسانی
//   // /// </summary>
//   // public FuelingType fuelType { get; set; }
//   //FuelingType fuelType=FuelingType.None;
//   int fuelType = -1;
//
//   // public bool hasTechnicalDiagnosis { get; set; }
//   bool hasTechnicalDiagnosis = false;
//
//   // public DateTime? technicalDiagnosisDateTime { get; set; }
//   String? technicalDiagnosisDateTime;
//
//   // public uint? technicalDiagnosisCenterId { get; set; }
//   int technicalDiagnosisCenterId = 0;
//
//   // public PollutionAnalyzeMethod pollutionAnalyzeMethod { get; set; }
//   //PollutionAnalyzeMethod pollutionAnalyzeMethod=PollutionAnalyzeMethod.ByAnalizer;
//   int pollutionAnalyzeMethod = -1;
//   int pollutantType = 0;
//
//   ///smoke????
//   // public double? o2Value { get; set; }
//   //double? o2Value;
//   // public double? landaValue { get; set; }
//   //double? lambdaValue;
//   // public double? coValue { get; set; }
//   //double? coValue;
//   // public double? hcValue { get; set; }
//   //double? hcValue;
//   // [Required(ErrorMessage ="بارگزاری مستندات تصویری الزامی است")]
//   // public string photo { get; set; }
//   String? photo = "";
//
//   // public double lat { get; set; }
//   double lat = 0;
//
//   // public double lng { get; set; }
//   double lng = 0;
//
//   // public uint officerId { get; set; }
//   int officerId = 0;
//
//   // public uint inspectorId { get; set; }
//   int cityZone = -1;
//
//   //int inspectorId = 0;
//
//   List<PollutantValue> pollutantsValue = [];
//
//   Map<String, dynamic> toJson2(){
//     Map<String, dynamic> x;
//     foreach(){
//       x.addEntries({pollutantsValue.});
//     }
//     return {};
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'recordedDocument': recordedDocument,
//       'recordedDocumentDescription': recordedDocumentDescription,
//       'relationWithOwner': relationWithOwner,
//       'carPlate': carPlate,
//       'ownerName': driverName,
//       'ownerFamily': driverFamily,
//       'ownerMobile': driverMobile,
//       'ownerNationalCode': driverNationalCode,
//       'ownerAddress': driverAddress,
//       'ownerDriveLicence': driverDriveLicence,
//       'carTypeId': carTypeId,
//       'carModel': carModel,
//       //'sourceCategoryId': sourceCategoryId,
//       'fuel': engineType,
//       'fuelType': fuelType,
//       'hasTechnicalDiagnosis': hasTechnicalDiagnosis,
//       'technicalDiagnosisDateTime': technicalDiagnosisDateTime,
//       'technicalDiagnosisCenterId': technicalDiagnosisCenterId,
//       'pollutionAnalyzeMethod': pollutionAnalyzeMethod,
//       // 'o2Value': o2Value,
//       // 'landaValue': lambdaValue,
//       // 'coValue': coValue,
//       // 'hcValue': hcValue,
//       'smokeType' : pollutantType,
//       'photo': photo,
//       'lat': lat,
//       'lng': lng,
//       'officerId': officerId,
//       'cityZone' : cityZone,
//       'pollutantsValue' : toJson2(),
//       //'inspectorId': inspectorId,
//     };
//   }
// }



import 'package:pollutant_inspection/enums/cars_pollutants.dart';
import 'package:pollutant_inspection/utility/map_to_list.dart';

class PollutantValue {
  CarsPollutants? pollutant;
  double? value;

  PollutantValue({this.pollutant, this.value});

  Map<String, dynamic> toJson() {
    return {
      'pollutant': pollutant?.index, // Adjust according to how you want to serialize CarsPollutants
      'value': value,
    };
  }
}

class PollutantRegisterModel {
  int recordedDocument = -1;
  String? recordedDocumentDescription;
  int relationWithOwner = -1;
  String carPlate = "";
  String driverName = "";
  String driverFamily = "";
  String driverMobile = "";
  String driverNationalCode = "";
  String driverAddress = "";
  String driverDriveLicence = "";
  int carTypeId = 0;
  int carModel = 0;
  int engineType = -1;
  int fuelType = -1;
  bool hasTechnicalDiagnosis = false;
  String? technicalDiagnosisDateTime;
  int technicalDiagnosisCenterId = 0;
  int pollutionAnalyzeMethod = -1;
  int pollutantType = 0;
  String? photo = "";
  double lat = 0;
  double lng = 0;
  int officerId = 0;
  int cityZone = -1;
  List<PollutantValue> pollutantsValue = [];

  Map<String, dynamic> toJson2() {
    return {
      'pollutantsValue': pollutantsValue.map((pv) => pv.toJson()).toList(),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'recordedDocument': recordedDocument,
      'recordedDocumentDescription': recordedDocumentDescription,
      'relationWithOwner': relationWithOwner,
      'carPlate': carPlate,
      'ownerName': driverName,
      'ownerFamily': driverFamily,
      'ownerMobile': driverMobile,
      'ownerNationalCode': driverNationalCode,
      'ownerAddress': driverAddress,
      'ownerDriveLicence': driverDriveLicence,
      'carTypeId': carTypeId,
      'carModel': carModel,
      'engineType': engineType,
      'fuelType': fuelType,
      'hasTechnicalDiagnosis': hasTechnicalDiagnosis,
      'technicalDiagnosisDateTime': technicalDiagnosisDateTime,
      'technicalDiagnosisCenterId': technicalDiagnosisCenterId,
      'pollutionAnalyzeMethod': pollutionAnalyzeMethod,
      'smokeType': pollutantType,
      'lat': lat,
      'lng': lng,
      'officerId': officerId,
      'cityZone': cityZone,
      'pollutantsValue': toJson2()['pollutantsValue'],
      'photo': photo,
    };
  }
}