import 'dart:convert';

NumberModel numberModelFromJson({required String str}) =>
    NumberModel.fromJson(json.decode(str));

String numberModelToJson({required List<NumberModel> data}) => json.encode(
    data.map<Map<String, dynamic>>((number) => number.toJson()).toList());

List<NumberModel> numberListFromJson({required String input}) =>
    (json.decode(input) as List<dynamic>)
        .map<NumberModel>((number) => NumberModel.fromJson(number))
        .toList();

class NumberModel {
  NumberModel({
    required this.valid,
    required this.localFormat,
    required this.intlFormat,
    required this.countryCode,
    required this.countryName,
    required this.location,
    required this.carrier,
    required this.lineType,
  });

  final bool valid;
  final String localFormat;
  final String intlFormat;
  final String countryCode;
  final String countryName;
  final String location;
  final String carrier;
  final String lineType;

  factory NumberModel.fromJson(Map<String, dynamic> json) => NumberModel(
        valid: json["valid"],
        localFormat: json["local_format"],
        intlFormat: json["international_format"],
        countryCode: json["country_code"],
        countryName: json["country_name"],
        location: json["location"],
        carrier: json["carrier"],
        lineType: json["line_type"],
      );

  Map<String, dynamic> toJson() => {
        "valid": valid,
        "local_format": localFormat,
        "international_format": intlFormat,
        "country_code": countryCode,
        "country_name": countryName,
        "location": location,
        "carrier": carrier,
        "line_type": lineType,
      };
}
