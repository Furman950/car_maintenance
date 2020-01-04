import 'package:car_maintenance/core/models/car.dart';
import 'package:car_maintenance/core/viewmodels/views/oil_changes_view_model.dart';
import 'package:car_maintenance/ui/views/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Column(
                children: <Widget>[
                  Text(car.model),
                  Text(car.make),
                  Text(car.vin)
                ],
              ),
              flexibleSpace: Placeholder(),
              expandedHeight: 150,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        child: ListTile(
                          title:
                              Text(model.dateTimeFormated(index)),
                          subtitle: Text(
                              'Mileage: ${model.oilChanges[index].mileage}'),
                        ),
                      ),
                  childCount: model.oilChanges?.length ?? 0),
            )
          ],
        ),
      ),
    );
  }
}
