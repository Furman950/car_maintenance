import 'package:http/http.dart' as http;

class CarApi {
  static const String host = 'http://192.168.1.34:5555';

  Future getMyCars() async {
    return await http.get('$host/api/cars/all');
  }

  Future getOilChangesWithVin(String vin) async {
    return await http.get('$host/api/oilchanges/$vin');
  }
}
