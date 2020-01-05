import 'package:car_maintenance/core/models/oil_change.dart';
import 'package:car_maintenance/core/services/car_api.dart';
import 'package:car_maintenance/core/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class OilChangeFormViewModel extends BaseModel {
  final CarApi _carApi;
  int _mileage = 0;
  String vin;
  OilChange oilChange;

  OilChangeFormViewModel({@required CarApi carApi}) : _carApi = carApi;

  Future<Response> saveOilChange(DateTime dateTime) async {
    oilChange = OilChange(vin: vin, mileage: _mileage, dateTime: dateTime);
    return _carApi.saveOilChange(oilChange);
  }

  onChange(String value) {
    _mileage = int.tryParse(value);
  }

  setVin(String vin) => this.vin = vin;
}
