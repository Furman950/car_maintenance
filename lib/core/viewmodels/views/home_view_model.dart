import 'package:car_maintenance/core/models/car.dart';
import 'package:car_maintenance/core/services/car_api.dart';
import 'package:car_maintenance/core/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends BaseModel {
  CarApi _carApi;

  HomeViewModel({@required CarApi carApi}) : _carApi = carApi;

  List<Car> _cars = [];
  List<Car> get cars => _cars;

  addCar(Car car) {
    _cars.add(car);
    notifyListeners();
  }

  void setCars(List<Car> cars) {
    cars.forEach((x) => print(x));
    _cars = cars;
    notifyListeners();
  }

  getMyCars() async {
    var res = await _carApi.getMyCars();
    var cars = carFromList(res.body);
    setCars(cars);
  }
}
