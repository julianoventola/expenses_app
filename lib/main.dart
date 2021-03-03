import 'dart:math';

import 'package:expenses/components/chart_build.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpensesApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.purple,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MySplashScreen(),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => new _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: MyHomePage(),
      image: Image.asset(
        'images/money.png',
      ),
      backgroundColor: Colors.white,
      title: Text(
        'Expenses',
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 2,
          color: Colors.green,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      photoSize: 100.0,
      loadingText: Text(
        'Best Expense Manager',
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 2,
          color: Theme.of(context).accentColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _showChartGraph = true;
  final List<Transaction> _transaction = [];

  List<Transaction> get _recentTransacion {
    return _transaction
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    if (title.isEmpty || value <= 0) {
      return;
    }

    final newTransaction = Transaction(
      id: (Random().nextInt(350) + _transaction.length + 1).toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TransactionForm(
                addTransaction: _addTransaction,
              ),
            ),
          );
        });
  }

  void _showChart() {
    setState(() {
      _showChartGraph = !_showChartGraph;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.insert_chart_outlined,
            color: Colors.yellow,
          ),
          onPressed: _showChart,
        )
      ],
      centerTitle: true,
      title: Text("Expense"),
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _showChartGraph
                ? Container(
                    height: availableHeight * (isLandscape ? 0.8 : 0.25),
                    width: double.infinity,
                    child: ChartBuild(
                      recentTransacion: _recentTransacion,
                    ))
                : Container(
                    child: null,
                  ),
            !isLandscape
                ? AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    height: availableHeight * (_showChartGraph ? 0.75 : 1),
                    child: TransactionList(
                      transactions: _transaction,
                      removeTransaction: _deleteTransaction,
                    ),
                  )
                : _showChartGraph
                    ? Container(
                        child: null,
                      )
                    : AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: availableHeight * (_showChartGraph ? 0.75 : 1),
                        child: TransactionList(
                          transactions: _transaction,
                          removeTransaction: _deleteTransaction,
                        ),
                      )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.attach_money,
          color: Colors.yellow,
        ),
        onPressed: () => _openTransactionModal(context),
      ),
    );
  }
}
