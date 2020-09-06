import '../models/transaction.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "./chart_bar.dart";

class Chart extends StatelessWidget {
  final List<Transaction> recTransactions;
  Chart(this.recTransactions);

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      double totalSum = 0.0;

      for(int i =0; i< recTransactions.length; i++) {
        if(recTransactions[i].date.year == weekDay.year &&
          recTransactions[i].date.month == weekDay.month &&
          recTransactions[i].date.day == weekDay.day) {
            totalSum += recTransactions[i].amount;
          }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    });
  }

  double get totalExpense {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: 
          groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: 
              ChartBar(data['day'], data['amount'], totalExpense == 0.0 ? 0.0 : (data['amount'] as double) / totalExpense,));
          }).toList(),
          ),
      ),
    );
  }
}