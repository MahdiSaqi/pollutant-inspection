// import 'package:pollutant_inspection/enums/cars_pollutants.dart';
// import 'package:pollutant_inspection/utility/map_to_list.dart';
//
// class PollutantValue {
//   CarsPollutants? pollutant;
//   double? value;
//
//   PollutantValue({this.pollutant, this.value});
//
//   Map<String, dynamic> toJson() {
//     return {
//       'pollutant': pollutant?.index, // Adjust according to how you want to serialize CarsPollutants
//       'value': value,
//     };
//   }
// }
//
// class PollutantRegisterModel {
//   int recordedDocument = -1;
//   String? recordedDocumentDescription;
//   int relationWithOwner = -1;
//   String carPlate = "";
//   String driverName = "";
//   String driverFamily = "";
//   String driverMobile = "";
//   String driverNationalCode = "";
//   String driverAddress = "";
//   String driverDriveLicence = "";
//   int carTypeId = 0;
//   int carModel = 0;
//   int engineType = -1;
//   int fuelType = -1;
//   bool hasTechnicalDiagnosis = false;
//   String? technicalDiagnosisDateTime;
//   int technicalDiagnosisCenterId = 0;
//   int pollutionAnalyzeMethod = -1;
//   int pollutantType = 0;
//   String? photo = "";
//   double lat = 0;
//   double lng = 0;
//   int officerId = 0;
//   int cityZone = -1;
//   List<PollutantValue> pollutantsValue = [];
//
//   Map<String, dynamic> toJson2() {
//     return {
//       'pollutantsValue': pollutantsValue.map((pv) => pv.toJson()).toList(),
//     };
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
//       'engineType': engineType,
//       'fuelType': fuelType,
//       'hasTechnicalDiagnosis': hasTechnicalDiagnosis,
//       'technicalDiagnosisDateTime': technicalDiagnosisDateTime,
//       'technicalDiagnosisCenterId': technicalDiagnosisCenterId,
//       'pollutionAnalyzeMethod': pollutionAnalyzeMethod,
//       'smokeType': pollutantType,
//       'lat': lat,
//       'lng': lng,
//       'officerId': officerId,
//       'cityZone': cityZone,
//       'pollutantsValue': toJson2()['pollutantsValue'],
//       'photo': photo,
//     };
//   }
// }


///TODO *********************
import 'package:pollutant_inspection/enums/cars_pollutants.dart';
import 'package:pollutant_inspection/utility/map_to_list.dart';

class PollutantValue {
  CarsPollutants? pollutant;
  double? value;

  PollutantValue({this.pollutant, this.value});

  Map<String, dynamic> toJson() {
    return {
      'pollutant': pollutant?.index,
      'value': value,
    };
  }

  factory PollutantValue.fromJson(Map<String, dynamic> json) {
    return PollutantValue(
      pollutant: json['pollutant'] != null ? CarsPollutants.values[json['pollutant']] : null,
      value: (json['value'] as num?)?.toDouble(),
    );
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

  // Explicit unnamed constructor
  PollutantRegisterModel();

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

  factory PollutantRegisterModel.fromJson(Map<String, dynamic> json) {
    return PollutantRegisterModel()
      ..recordedDocument = json['recordedDocument'] ?? -1
      ..recordedDocumentDescription = json['recordedDocumentDescription']
      ..relationWithOwner = json['relationWithOwner'] ?? -1
      ..carPlate = json['carPlate'] ?? ""
      ..driverName = json['ownerName'] ?? ""
      ..driverFamily = json['ownerFamily'] ?? ""
      ..driverMobile = json['ownerMobile'] ?? ""
      ..driverNationalCode = json['ownerNationalCode'] ?? ""
      ..driverAddress = json['ownerAddress'] ?? ""
      ..driverDriveLicence = json['ownerDriveLicence'] ?? ""
      ..carTypeId = json['carTypeId'] ?? 0
      ..carModel = json['carModel'] ?? 0
      ..engineType = json['engineType'] ?? -1
      ..fuelType = json['fuelType'] ?? -1
      ..hasTechnicalDiagnosis = json['hasTechnicalDiagnosis'] ?? false
      ..technicalDiagnosisDateTime = json['technicalDiagnosisDateTime']
      ..technicalDiagnosisCenterId = json['technicalDiagnosisCenterId'] ?? 0
      ..pollutionAnalyzeMethod = json['pollutionAnalyzeMethod'] ?? -1
      ..pollutantType = json['smokeType'] ?? 0
      ..photo = json['photo'] ?? ""
      ..lat = (json['lat'] as num?)?.toDouble() ?? 0.0
      ..lng = (json['lng'] as num?)?.toDouble() ?? 0.0
      ..officerId = json['officerId'] ?? 0
      ..cityZone = json['cityZone'] ?? -1
      ..pollutantsValue = (json['pollutantsValue'] as List<dynamic>?)
          ?.map((pvJson) => PollutantValue.fromJson(pvJson))
          .toList() ?? [];
  }
}