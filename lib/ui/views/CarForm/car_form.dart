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
  final Map<String, TextEditingController> _textEditingControllers = {
    'vin': TextEditingController(),
    'make': TextEditingController(),
    'model': TextEditingController(),
    'nickname': TextEditingController()
  };

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

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarFormViewModel>(
      model: CarFormViewModel(_textEditingControllers,
          carApi: Provider.of(context)),
      onModelReady: (model) => model.setYear(currentYear),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Create a new Car'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _textEditingControllers['vin'],
                      validator: model.validator,
                      decoration: InputDecoration(
                          labelText: 'Vin*', hintText: 'Enter Car Vin'),
                    ),
                    TextFormField(
                      controller: _textEditingControllers['make'],
                      validator: model.validator,
                      decoration: InputDecoration(
                          labelText: 'Make*', hintText: 'Enter Make'),
                    ),
                    TextFormField(
                      controller: _textEditingControllers['model'],
                      validator: model.validator,
                      decoration: InputDecoration(
                          labelText: 'Model*', hintText: 'Enter Model'),
                    ),
                    TextFormField(
                      controller: _textEditingControllers['nickname'],
                      decoration: InputDecoration(
                          labelText: 'Nickname', hintText: 'Enter Nickname'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Car Year'),
                        SizedBox(
                          width: 100,
                        ),
                        DropdownButton(
                          value: model.year,
                          items: _yearsList,
                          onChanged: model.setYear,
                        ),
                      ],
                    ),
                    RaisedButton(
                      child: Text('Save'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          var res = await model.saveCar();
                          if (res.statusCode == 201) {
                            Navigator.pop(context, model.car);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            model.busy
                ? Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.3,
                        child: const ModalBarrier(
                          dismissible: false,
                          color: Colors.grey,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
