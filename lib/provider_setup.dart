import 'package:car_maintenance/core/services/car_api.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(
    value: CarApi(),
  ),
];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> uiConsumableProviders = [];