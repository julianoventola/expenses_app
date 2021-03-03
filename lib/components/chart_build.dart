import 'package:expenses/components/chart_bar.dart';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ChartBuild extends StatelessWidget {
  final List<Transaction> recentTransacion;

  ChartBuild({this.recentTransacion});

  List<Map<String, Object>> get grounpedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransacion.length; i++) {
        bool sameDay = recentTransacion[i].date.day == weekDay.day;
        bool sameMonth = recentTransacion[i].date.month == weekDay.month;
        bool sameYear = recentTransacion[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransacion[i].value;
        }
      }

      return {
        'day': '${DateFormat.EEEE().format(weekDay).substring(0, 3)}',
        'value': totalSum,
      };
    });
  }

  double get _weekTotalValue {
    return grounpedTransaction.fold(0, (sum, transaction) {
      return sum + transaction['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grounpedTransaction
              .map((transaction) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: transaction['day'],
                    value: transaction['value'],
                    percentage: _weekTotalValue == 0
                        ? 0
                        : ((transaction['value'] as double) / _weekTotalValue),
                  ),
                );
              })
              .toList()
              .reversed
              .toList(),
        ),
      ),
    );
  }
}
