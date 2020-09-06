import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {

    if(titleController.text.isEmpty || double.parse(amountController.text) <= 0 || amountController.text.isEmpty || selectedDate == null) {
      return;
    }
    widget.addTransaction(titleController.text, double.parse(amountController.text), selectedDate,);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now())
    .then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    
    return Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
              TextField(decoration: InputDecoration(labelText: "Enter Title"), controller: titleController, onSubmitted: (_) => submitData,),
              TextField(decoration: InputDecoration(labelText: "Enter Amount"), controller: amountController, keyboardType: TextInputType.number, onSubmitted: (_) => submitData(),),
              Container(
                height: 80,
                child: Row(children: [
                  Expanded(child: 
                  Text(selectedDate == null? "No Date Chosen!": 'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}')),
                  FlatButton(textColor: Theme.of(context).primaryColor, child: Text("Choose Date!", style: TextStyle(fontWeight: FontWeight.bold,)), onPressed: presentDatePicker,),
                ],),
              ),
              RaisedButton(onPressed: submitData, child: Text("Add Expense"), color: Theme.of(context).primaryColor,textColor: Colors.white,),
            ],),
        ),
      );
  }
}