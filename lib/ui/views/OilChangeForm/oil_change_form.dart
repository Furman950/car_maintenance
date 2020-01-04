import 'package:car_maintenance/core/util/date_parser.dart';
import 'package:car_maintenance/core/viewmodels/views/oil_change_form_view_model.dart';
import 'package:car_maintenance/ui/views/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
        context: context,
        initialTime: prefix0.TimeOfDay.fromDateTime(_dateTime));
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
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Add oil change to Car'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: 'Enter Mileage',
                    hintText: 'Enter current vehicle mileage'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
              ),
              Text('Date ${formatDate(_dateTime)}'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
