import 'package:car_maintenance/core/constants/app_contstants.dart';
import 'package:car_maintenance/core/models/car.dart';
import 'package:car_maintenance/ui/views/CarForm/car_form.dart';
import 'package:car_maintenance/ui/views/Home/home.dart';
import 'package:car_maintenance/ui/views/Oilchanges/oil_changes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.Home:
        return MaterialPageRoute(builder: (_) => Home());
      case RoutePath.OilChanges:
        final Car car = settings.arguments;
        return MaterialPageRoute(builder: (_) => OilChanges(car: car));
      case RoutePath.CarForm:
        return MaterialPageRoute(builder: (_) => CarForm());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
