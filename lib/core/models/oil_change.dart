import 'dart:convert';

import 'package:intl/intl.dart';

List<OilChange> oilChangeFromList(String str) =>
    List<OilChange>.from(json.decode(str).map((x) => OilChange.fromJson(x)));

String oilChangeToJson(OilChange oilChange) => json.encode(oilChange.toJson());

class OilChange {
  String vin;
  int mileage;
  DateTime dateTime;
  OilChange({this.vin, this.mileage, this.dateTime}) {
    DateTime.now();
  }

  factory OilChange.fromJson(Map<String, dynamic> json) => OilChange(
      vin: json["vin"],
      mileage: json["mileage"],
      dateTime: DateTime.parse(json["dateTime"]),
    );

    Map<String, dynamic> toJson() => {
      "vin": vin,
      "mileage": mileage,
      "dateTime": DateFormat("yyyy-MM-dd hh:mm:ss").format(dateTime)
    };
}
