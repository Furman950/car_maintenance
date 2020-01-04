import 'package:car_maintenance/core/constants/app_contstants.dart';
import 'package:car_maintenance/core/models/car.dart';
import 'package:car_maintenance/core/viewmodels/views/home_view_model.dart';
import 'package:car_maintenance/ui/views/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(carApi: Provider.of(context)),
      onModelReady: (model) => model.getMyCars(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final car = await Navigator.pushNamed(context, RoutePath.CarForm);
            if (car is Car) {
              model.addCar(car);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added ${car.model}'),
                ),
              );
            }
          },
          child: Icon(Icons.add),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Your cars'),
              // floating: true,
              flexibleSpace: Placeholder(),
              expandedHeight: 200,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final int itemIndex = index ~/ 2;
                  return index.isEven
                      ? Container(
                          child: ListTile(
                            title: Text(model.cars[itemIndex].model),
                            onTap: () => Navigator.pushNamed(
                              context,
                              RoutePath.OilChanges,
                              arguments: model.cars[itemIndex],
                            ),
                            subtitle: Text(
                                '${model.cars[itemIndex].vin}\n${model.cars[itemIndex].make}\n${model.cars[itemIndex].yearManufactured}'),
                          ),
                        )
                      : Divider(
                          height: 0,
                          color: Colors.grey,
                        );
                },
                // semanticIndexCallback: (widget, localIndex) =>
                //     localIndex.isEven ? localIndex ~/ 2 : null,
                childCount: math.max(0, (model.cars?.length ?? 0) * 2 - 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
