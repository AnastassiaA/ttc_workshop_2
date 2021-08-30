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
  final items = List<String>.generate(20, (i) => "Item $i");

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff2C041C),
          foregroundColor: Colors.white,
          title: const Text('Expenses'),
        ),
        drawer: MyDrawer(),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}
