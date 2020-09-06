import 'package:expense_manager/models/transaction.dart';
import "package:flutter/material.dart";
import "../models/transaction.dart";
import "package:intl/intl.dart";

class TransactionList extends StatelessWidget {

   final List<Transaction> transactions;
   final Function delTransaction;

   TransactionList(this.transactions, this.delTransaction);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      child: transactions.isEmpty ? Column(children: [
        Text("No Transaction added yet!"),
        SizedBox(height: 30,),
        Container(height: 200,child: Image.network("https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/zzz.png", fit: BoxFit.cover)),
      ],)
      : 
      ListView.builder(
        itemBuilder: (context, index) {
          return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\₹${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(icon: Icon(Icons.delete), color: Colors.red, onPressed: () => delTransaction(transactions[index].id),),
                  ),
                );
        },
        itemCount: transactions.length,
      ),
    );
  }
}