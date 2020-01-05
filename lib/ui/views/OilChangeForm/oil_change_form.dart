import 'package:car_maintenance/core/util/date_parser.dart';
import 'package:car_maintenance/core/viewmodels/views/oil_change_form_view_model.dart';
import 'package:car_maintenance/ui/views/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OilChangeForm extends StatefulWidget {
  final String vin;

  const OilChangeForm({this.vin});

  @override
  _OilChangeFormState createState() => _OilChangeFormState();
}

class _OilChangeFormState extends State<OilChangeForm> {
  final _formKey = GlobalKey<FormState>();
  var _dateTime = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(_dateTime.year),
        lastDate: DateTime(_dateTime.year + 1));

    if (dateTime != null && dateTime != _dateTime) {
      setState(() {
        _dateTime = dateTime;
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay time = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(_dateTime));
    print(time);

    if (time != null) {
      print('Setting new state');
      setState(() {
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            time.hour, time.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<OilChangeFormViewModel>(
      model: OilChangeFormViewModel(carApi: Provider.of(context)),
      onModelReady: (model) => model.setVin(widget.vin),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Add oil change to Car'),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Enter Mileage',
                      hintText: 'Enter current vehicle mileage'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  onChanged: model.onChange,
                  validator: (value) =>
                      value.isEmpty ? 'This value is required!' : null,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Date ${formatDate(_dateTime)}',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Change date'),
                      onPressed: () => _selectDate(context),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      child: const Text('Change time'),
                      onPressed: () => _selectTime(context),
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                RaisedButton(
                  child: const Text('Save Oil Change'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var res = await model.saveOilChange(_dateTime);
                      if (res.statusCode == 201){
                        Navigator.pop(context, model.oilChange);
                      }

                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
