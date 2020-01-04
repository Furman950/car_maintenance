import 'package:car_maintenance/core/models/car.dart';
import 'package:car_maintenance/core/services/car_api.dart';
import 'package:car_maintenance/core/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class CarFormViewModel extends BaseModel {
  CarApi _carApi;
  int _year;
  int get year => _year;
  Car car;

  setYear(int year) {
    _year = year;
    notifyListeners();
  }

  final Map<String, TextEditingController> _textEditingControllers;

  CarFormViewModel(this._textEditingControllers, {@required CarApi carApi})
      : _carApi = carApi;

  Future<Response> saveCar() async {
    setBusy(true);
    var carMap = Map<String, dynamic>();
    _textEditingControllers.keys.forEach(
        (key) => carMap[key] = _textEditingControllers[key].value.text);
    carMap['yearManufactured'] = _year;
    var res = await _carApi.saveCar(carMap);
    car = Car.fromJson(carMap);
    setBusy(false);
    return res;
  }

  String validator(String value) =>
      value.isEmpty ? 'This value is required!' : null;
}
