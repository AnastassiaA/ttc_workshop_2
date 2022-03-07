import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';
import 'package:ttc_workshop_2/main.dart';
import 'package:ttc_workshop_2/drawer_contents/miscInfo.dart';
import 'package:ttc_workshop_2/drawer_contents/product.dart';
import 'package:ttc_workshop_2/drawer_contents/orderHome.dart';
import 'package:ttc_workshop_2/drawer_contents/toolHome.dart';
import 'package:ttc_workshop_2/drawer_contents/handexercises.dart';
import 'package:ttc_workshop_2/drawer_contents/timer.dart';
import 'package:ttc_workshop_2/drawer_contents/yarnthreadthings.dart';

import 'drawer_contents/accounting_dashboard.dart';
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
            child: Text(
              'TTC Workshop',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ListTile(
                leading: FaIcon(FontAwesomeIcons.houseUser),
                title: Text('Home'),
                tileColor: const Color(0xffE9DCE5),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.stopwatch),
            title: Text('Timer'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemTimer()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.receipt),
            title: Text('Orders'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderHome()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.yarn),
            title: Text('Yarns, Hooks, etc.'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThreadHook()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.hammer),
            title: Text('Tools List'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {},
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
            title: Text('Accounting'),
            //Expense, Revenue, all the fancy stuff
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountingDashboard()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.solidImages),
            title: Text('Product Catalogue'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Product()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.hashtag),
            title: Text('Insta Profile'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {},
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.solidQuestionCircle),
            title: Text('Miscellaneous'),
            //Brands, Sellers
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MiscInfo()),
              );
            },
          ),
          //TDDO: make drawer auto adjust to different sized devices
        ],
      ),
    );
  }
}
