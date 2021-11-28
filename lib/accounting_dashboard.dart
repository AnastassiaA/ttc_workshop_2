import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

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
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Accounting'),
        ),
        drawer: MyDrawer(),
        body: PageView(
          controller: pageviewController,
          children: [
            Text('Invoices'),
            Text('Expenses'),
            Text('Sales'),
            Text('Profit and Loss'),
            Text('Bank Accounts'),
          ],
        ),
      ),
    );
  }
}
