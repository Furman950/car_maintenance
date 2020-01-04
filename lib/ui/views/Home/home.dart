import 'package:car_maintenance/core/constants/app_contstants.dart';
import 'package:car_maintenance/core/viewmodels/views/home_view_model.dart';
import 'package:car_maintenance/ui/views/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//SliverAppBar
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(carApi: Provider.of(context)),
      onModelReady: (model) => model.getMyCars(),
      builder: (context, model, child) => Scaffold(
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
                  (context, index) => Container(
                        child: ListTile(
                          title: Text(model.cars[index].model),
                          onTap: () => Navigator.pushNamed(
                            context,
                            RoutePath.OilChanges,
                            arguments: model.cars[index],
                          ),
                          subtitle: Text(
                              '${model.cars[index].vin}\n${model.cars[index].make}\n${model.cars[index].yearManufactured}'),
                        ),
                      ),
                  childCount: model.cars?.length ?? 0),
            )
          ],
        ),
      ),
    );
  }
}
