import 'package:car_maintenance/core/services/car_api.dart';
import 'package:car_maintenance/core/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';

class OilChangeFormViewModel extends BaseModel {
  final CarApi _carApi;

  OilChangeFormViewModel({@required CarApi carApi}) : _carApi = carApi;

  saveOilChange() async {}
}
