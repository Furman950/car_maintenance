import 'package:car_maintenance/core/models/oil_change.dart';
import 'package:car_maintenance/core/services/car_api.dart';
import 'package:car_maintenance/core/util/date_parser.dart';
import 'package:car_maintenance/core/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';

class OilChangesViewModel extends BaseModel {
  CarApi _carApi;

  OilChangesViewModel({@required CarApi carApi}) : _carApi = carApi;

  List<OilChange> _oilChanges = [];
  List<OilChange> get oilChanges => _oilChanges;

  addOilChange(OilChange oilChange) {
    _oilChanges.add(oilChange);
    notifyListeners();
  }

  setOilChanges(List<OilChange> oilChanges) {
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

  String dateTimeFormated(int index) => formatDate(_oilChanges[index].dateTime);
}
