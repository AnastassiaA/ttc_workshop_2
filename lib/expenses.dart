import 'package:ttc_workshop_2/db_code/db_expense.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class ExpenseHome extends StatefulWidget {
  @override
  ExpenseState createState() {
    return ExpenseState();
  }
}

class ExpenseState extends State<ExpenseHome> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text('Expenses'),
      ),
      drawer: MyDrawer(),
      body: Container(),
    );
  }
}
