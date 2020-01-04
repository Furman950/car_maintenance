import 'package:car_maintenance/core/constants/app_contstants.dart';
import 'package:car_maintenance/core/models/car.dart';
import 'package:car_maintenance/core/models/oil_change.dart';
import 'package:car_maintenance/core/viewmodels/views/oil_changes_view_model.dart';
import 'package:car_maintenance/ui/views/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class OilChanges extends StatefulWidget {
  final Car car;

  OilChanges({@required this.car});

  @override
  _OilChangesState createState() => _OilChangesState();
}

class _OilChangesState extends State<OilChanges> {
  @override
  Widget build(BuildContext context) {
    var car = widget.car;
    return BaseWidget<OilChangesViewModel>(
      model: OilChangesViewModel(carApi: Provider.of(context)),
      onModelReady: (model) => model.getOilChangesWithVin(car.vin),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final oilChange = await Navigator.pushNamed(
                context, RoutePath.OilChangeForm,
                arguments: car.vin);
            if (oilChange is OilChange) {
              model.addOilChange(oilChange);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added Oil Change'),
                ),
              );
            }
          },
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('${car.model} ${car.make} ${car.vin}'),
              flexibleSpace: Placeholder(),
              expandedHeight: 150,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final int itemIndex = index ~/ 2;
                  return index.isEven
                      ? Container(
                          child: ListTile(
                            title: Text(model.dateTimeFormated(itemIndex)),
                            subtitle: Text(
                                'Mileage: ${model.oilChanges[itemIndex].mileage}'),
                          ),
                        )
                      : Divider();
                },
                childCount:
                    math.max(0, (model.oilChanges?.length ?? 0) * 2 - 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
