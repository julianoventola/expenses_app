import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransaction;
  const TransactionList({Key key, this.transactions, this.removeTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(constraints.maxHeight * 0.02),
                    child: Container(
                      height: constraints.maxHeight * 0.05,
                      child: FittedBox(
                        child: Text(
                          'No transactions registered ',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'images/waiting.png',
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transac = transactions[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$ ${transac.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),

                  /* Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Container(
                      width: 108,
                      child: FittedBox(
                        child: Text(
                          'R\$ ${transac.value.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),*/
                  title: Text(transac.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  subtitle: Text(
                    DateFormat('dd MMM y ').format(transac.date),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => removeTransaction(transac.id),
                  ),
                ),
                elevation: 4,
              );
            },
          );
  }
}
