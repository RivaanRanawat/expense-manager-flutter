import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import "./models/transaction.dart";
import "./widgets/chart.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.red),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> userTransaction = [];

  void addTx(String txTitle, double txAmount, DateTime pickedDate) {
    final newTx = Transaction(id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: pickedDate,);
    setState(() {
      userTransaction.add(newTx);
    });
  }

  List <Transaction> get recTransaction {
    return userTransaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }

  void openShowModel(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(addTx);
    },);
  }

  void delTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => openShowModel(context),),
        ],
      ),
      body: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,children: [
          Chart(recTransaction),
          TransactionList(userTransaction, delTransaction),
        ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => openShowModel(context),),
    );
  }
}
