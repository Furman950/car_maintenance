import 'package:car_maintenance/core/viewmodels/views/car_form_view_model.dart';
import 'package:car_maintenance/ui/views/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarForm extends StatefulWidget {
  @override
  _CarFormState createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  final _formKey = GlobalKey<FormState>();
  final currentYear = DateTime.now().year;
  final Map<String, TextEditingController> _textEditingControllers = {};
  List<DropdownMenuItem<int>> _yearsList;

  _CarFormState() {
    _generateYears();
  }

  _generateYears() {
    _yearsList = List<DropdownMenuItem<int>>();
    int minYear = currentYear - 25;
    for (int i = currentYear; i > minYear; i--) {
      _yearsList.add(
        DropdownMenuItem(
          value: i,
          child: Text('$i'),
        ),
      );
    }
  }

  void _onYearChange(int value) {}

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarFormViewModel>(
      model: CarFormViewModel(_textEditingControllers,
          carApi: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Create a new Car'),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Vin*', hintText: 'Enter Car Vin'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Make*', hintText: 'Enter Make'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Model*', hintText: 'Enter Model'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Nick Name', hintText: 'Enter nick name'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Car Year'),
                    SizedBox(
                      width: 100,
                    ),
                    DropdownButton(
                      value: currentYear,
                      items: _yearsList,
                      onChanged: _onYearChange,
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () => print('fudge'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
