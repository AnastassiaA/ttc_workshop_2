import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../drawer.dart';
import '../expenses.dart';

class AccountingDashboard extends StatefulWidget {
  @override
  AccDashboard createState() {
    return AccDashboard();
  }
}

class AccDashboard extends State<AccountingDashboard> {
  final pageviewController = PageController(
    initialPage: 1,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
            backgroundColor: const Color(0xffE9DCE5),
            appBar: AppBar(
              backgroundColor: const Color(0xff693b58),
              foregroundColor: Colors.white,
              title: const Text('Accounting'),
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Expense'),
                  Tab(text: 'Profits'),
                  Tab(text: 'Crochet Hooks'),
                  Tab(text: 'Knitting Needles'),
                ],
              ),
            ),
            drawer: MyDrawer(),
            body: TabBarView(
              children: [
                ExpenseHome(),
                Icon(Icons.directions_bike),
                Icon(Icons.directions_bike),
                Icon(Icons.directions_bike),
              ],
            )),
      ),
    );
  }
}
