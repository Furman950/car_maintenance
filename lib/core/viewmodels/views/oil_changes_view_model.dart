import 'package:car_maintenance/core/models/oil_change.dart';
import 'package:car_maintenance/core/services/car_api.dart';
import 'package:car_maintenance/core/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class OilChangesViewModel extends BaseModel {
  CarApi _carApi;

  OilChangesViewModel({@required CarApi carApi}) : _carApi = carApi;

  List<OilChange> _oilChanges = [];
  List<OilChange> get oilChanges => _oilChanges;

  void setOilChanges(List<OilChange> oilChanges) {
    _oilChanges = oilChanges;
    notifyListeners();
  }

  getOilChangesWithVin(String vin) async {
    setBusy(true);
    var res = await _carApi.getOilChangesWithVin(vin);
    var oilChanges = oilChangeFromList(res.body);
    oilChanges.forEach(print);
    setOilChanges(oilChanges);
    setBusy(false);
  }

  String dateTimeFormated(int index) =>
      DateFormat("MM/dd/yyyy hh:mm a").format(_oilChanges[index].dateTime);
}
