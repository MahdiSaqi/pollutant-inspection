
import 'base_definitionDTO.dart';

class SIMALoginInfo {
  int id; // Same note on uint as before
  String fullName;
  String lastLoginTime;
  String lastLoginIp;
  String token;
  //----
  //List<BaseDefinitionDTO> technicalCenters;
  //List<BaseDefinitionDTO> carTypes;
  //List<BaseDefinitionDTO> sourceCategories;
  //List<BaseDefinitionDTO> officers;

  SIMALoginInfo({
    required this.id,
    required this.fullName,
    required this.lastLoginTime,
    required this.lastLoginIp,
    required this.token,
    //required this.technicalCenters,
    //required this.carTypes,
    //required this.sourceCategories,
    //required this.officers,
  });

  // Optional: Create a method to convert JSON to SIMALoginOutput
  factory SIMALoginInfo.fromJson(Map<String, dynamic> json) {
    return SIMALoginInfo(
      id: json['id'],
      fullName: json['fullName'],
      lastLoginTime: json['lastLoginTime'],
      lastLoginIp: json['lastLoginIp'],
      token: json['token'],
      //technicalCenters: List<BaseDefinitionDTO>.from(json['technicalCenters'].map((x) => BaseDefinitionDTO.fromJson(x))),
      //carTypes: List<BaseDefinitionDTO>.from(json['carTypes'].map((x) => BaseDefinitionDTO.fromJson(x))),
      //sourceCategories: List<BaseDefinitionDTO>.from(json['sourceCategories'].map((x) => BaseDefinitionDTO.fromJson(x))),
      //officers: List<BaseDefinitionDTO>.from(json['officers'].map((x) => BaseDefinitionDTO.fromJson(x))),
    );
  }

  // Optional: Convert SIMALoginOutput to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'lastLoginTime': lastLoginTime,
      'lastLoginIp': lastLoginIp,
      'token': token,
      //'technicalCenters': technicalCenters.map((x) => x.toJson()).toList(),
      //'carTypes': carTypes.map((x) => x.toJson()).toList(),
      //'sourceCategories': sourceCategories.map((x) => x.toJson()).toList(),
      //'officers': officers.map((x) => x.toJson()).toList(),
    };
  }
}
