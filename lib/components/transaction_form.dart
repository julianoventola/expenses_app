import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) addTransaction;

  TransactionForm({Key key, this.addTransaction}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    widget.addTransaction(
      _titleController.text,
      double.tryParse(_valueController.text.replaceAll(',', '.')) ?? 0,
      _selectedDate,
    );
  }

  _showDatePicker() async {
    _selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    setState(() {
      _selectedDate = _selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => _submitForm(),
              onChanged: (newValue) {
                _titleController.text = newValue;
              },
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (newValue) {
                _valueController.text = newValue;
              },
              decoration: InputDecoration(
                labelText: 'Value (R\$)',
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No day selected!'
                        : 'Date: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  FlatButton(
                    onPressed: _showDatePicker,
                    child: Text('Select Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).accentColor,
                        )),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: _submitForm,
                child: Text(
                  'New Transaction',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
