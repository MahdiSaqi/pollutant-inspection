class MyHttpResponse
{
  int? statusCode;
  List<String>? errors;
  String? data;
  MyHttpResponse({this.statusCode,this.errors,this.data});

  factory MyHttpResponse.fromJson(Map<String, dynamic> json) {
    return MyHttpResponse(
      statusCode: json['statusCode'] as int?,
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
      data: json['data'] as String?,
    );
  }

}