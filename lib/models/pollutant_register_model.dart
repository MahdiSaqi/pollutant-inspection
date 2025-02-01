// import 'dart:ffi';

import 'package:pollutant_inspection/enums/cars_pollutants.dart';

class PollutantValue{
  CarsPollutants? pollutant ;
  double? value ;
  PollutantValue({this.pollutant,this.value});
}

class PollutantRegisterModel {
  // public RecordedDocument recordedDocument { get; set; }
  //RecordedDocument recordedDocument=RecordedDocument.CarCard;
  int recordedDocument = -1;

  //int actionType=0;
  // public string? recordedDocumentDescription { get; set; }
  String? recordedDocumentDescription;

  // public RelationWithOwner relationWithOwner { get; set; }
  //RelationWithOwner relationWithOwner=RelationWithOwner.Owner;
  int relationWithOwner = -1;

  // [Required(ErrorMessage ="پلاک وارد نشده است")]
  // public string carPlate { get; set; }
  String carPlate = "";

  // [Required(ErrorMessage ="نام مالک وارد نشده است")]
  // public string ownerName { get; set; }
  String driverName = "";

  // [Required(ErrorMessage ="نام خانوادگی مالک وارد نشده است")]
  // public string ownerFamily { get; set; }
  String driverFamily = "";

  // [Required(ErrorMessage ="شماره تلفن مالک وارد نشده است")]
  // public string ownerMobile { get; set; }
  String driverMobile = "";

  // [Required(ErrorMessage ="کدملی مالک وارد نشده است")]
  // public string ownerNationalCode { get; set; }
  String driverNationalCode = "";

  // [Required(ErrorMessage ="آدرس مالک وارد نشده است")]
  // public string ownerAddress { get; set; }
  String driverAddress = "";

  // [Required(ErrorMessage ="شماره گواهینامه مالک وارد نشده است")]
  // public string ownerDriveLicence { get; set; }
  String driverDriveLicence = "";

  // [Required(ErrorMessage ="نوع خودرو وارد نشده است")]
  // public uint? carTypeId { get; set; }
  int carTypeId = 0;

  //
  // /// <summary>
  // /// سال ساخت
  // /// </summary>
  // public short carModel { get; set; }
  int carModel = 0;

  // /// <summary>
  // /// طبقه بندی منبع
  // /// </summary>
  // [Required(ErrorMessage ="نوع منبع خودرو وارد نشده است")]
  // public uint? sourceCategoryId { get; set; }
  //int? sourceCategoryId;
  // public FuelType fuel { get; set; }
  //FuelType fuel=FuelType.Petrol;
  int engineType = -1;

  // /// <summary>
  // /// نوع سوخت رسانی
  // /// </summary>
  // public FuelingType fuelType { get; set; }
  //FuelingType fuelType=FuelingType.None;
  int fuelType = -1;

  // public bool hasTechnicalDiagnosis { get; set; }
  bool hasTechnicalDiagnosis = false;

  // public DateTime? technicalDiagnosisDateTime { get; set; }
  String? technicalDiagnosisDateTime;

  // public uint? technicalDiagnosisCenterId { get; set; }
  int technicalDiagnosisCenterId = 0;

  // public PollutionAnalyzeMethod pollutionAnalyzeMethod { get; set; }
  //PollutionAnalyzeMethod pollutionAnalyzeMethod=PollutionAnalyzeMethod.ByAnalizer;
  int pollutionAnalyzeMethod = -1;
  int pollutantType = 0;

  ///smoke????
  // public double? o2Value { get; set; }
  //double? o2Value;
  // public double? landaValue { get; set; }
  //double? lambdaValue;
  // public double? coValue { get; set; }
  //double? coValue;
  // public double? hcValue { get; set; }
  //double? hcValue;
  // [Required(ErrorMessage ="بارگزاری مستندات تصویری الزامی است")]
  // public string photo { get; set; }
  String? photo = "";

  // public double lat { get; set; }
  double lat = 0;

  // public double lng { get; set; }
  double lng = 0;

  // public uint officerId { get; set; }
  int officerId = 0;

  // public uint inspectorId { get; set; }
  int cityZone = -1;

  //int inspectorId = 0;

  List<PollutantValue> pollutantsValue = [];

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
      //'sourceCategoryId': sourceCategoryId,
      'fuel': engineType,
      'fuelType': fuelType,
      'hasTechnicalDiagnosis': hasTechnicalDiagnosis,
      'technicalDiagnosisDateTime': technicalDiagnosisDateTime,
      'technicalDiagnosisCenterId': technicalDiagnosisCenterId,
      'pollutionAnalyzeMethod': pollutionAnalyzeMethod,
      // 'o2Value': o2Value,
      // 'landaValue': lambdaValue,
      // 'coValue': coValue,
      // 'hcValue': hcValue,
      'smokeType' : pollutantType,
      'photo': photo,
      'lat': lat,
      'lng': lng,
      'officerId': officerId,
      'cityZone' : cityZone,
      'pollutantsValue' : pollutantsValue,
      //'inspectorId': inspectorId,
    };
  }
}