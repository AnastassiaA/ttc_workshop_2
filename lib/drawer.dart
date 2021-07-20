import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/main.dart';
import 'package:ttc_workshop_2/product.dart';
import 'package:ttc_workshop_2/order.dart';
import 'package:ttc_workshop_2/tool.dart';
import 'package:ttc_workshop_2/handexercises.dart';
import 'package:ttc_workshop_2/timer.dart';
import 'package:ttc_workshop_2/expenses.dart';
import 'package:ttc_workshop_2/yarnthreadthings.dart';

import 'home page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/ttc_image.jpg"), fit: BoxFit.cover),
            ),
            child: Text(''),
          ),
          ListTile(
            title: Text('Home'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
          ListTile(
            title: Text('Timer'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ItemTimer()),
              // );
            },
          ),
          ListTile(
            title: Text('Orders'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderHome()),
              );
            },
          ),
          ListTile(
            title: Text('Expenses'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExpenseHome()),
              );
            },
          ),
          ListTile(
            title: Text('Product Catalogue'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Product()),
              );
            },
          ),
          ListTile(
            title: Text('Hand Exercises'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HandExercise()),
              );
            },
          ),
          ListTile(
            title: Text('Tools List'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {},
          ),
          ListTile(
            title: Text('Instagram'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {},
          ),
          ListTile(
            title: Text('Facebook'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {},
          ),
          ListTile(
            title: Text('Yarns, Hooks, etc.'),
            tileColor: const Color(0xfff5d96b),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThreadHook()),
              );
            },
          ),
        ],
      ),
    );
  }
}
