import 'dart:convert';

List<Car> carFromList(String str) =>
    List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  String vin;
  String make;
  String model;
  int yearManufactured;

  Car({
    this.vin,
    this.make,
    this.model,
    this.yearManufactured,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        vin: json["vin"],
        make: json["make"],
        model: json["model"],
        yearManufactured: json["yearManufactured"],
      );

  Map<String, dynamic> toJson() => {
        "vin": vin,
        "make": make,
        "model": model,
        "yearManufactured": yearManufactured,
      };
}
