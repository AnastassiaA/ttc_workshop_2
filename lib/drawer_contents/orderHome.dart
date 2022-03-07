import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/cards/orderCard.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';
import 'package:ttc_workshop_2/forms/addOrder.dart';
import 'package:ttc_workshop_2/models/order_model.dart';
import 'package:ttc_workshop_2/tabs/order_tab.dart';
import '../drawer.dart';
//===============================================//

class OrderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Orders'),
        ),
        drawer: MyDrawer(),
        body: OrderList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff997ABD),
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddOrderForm()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
