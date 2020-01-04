import 'package:car_maintenance/core/services/car_api.dart';
import 'package:car_maintenance/core/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';

class CarFormViewModel extends BaseModel {
  CarApi _carApi;
  final Map<String, TextEditingController> _textEditingControllers;

  CarFormViewModel(this._textEditingControllers, {@required CarApi carApi})
      : _carApi = carApi;
}
