import 'package:car_maintenance/provider_setup.dart';
import 'package:car_maintenance/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(CarMaintenance());

class CarMaintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600]
        ),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
