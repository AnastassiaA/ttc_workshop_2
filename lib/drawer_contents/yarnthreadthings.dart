import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';
import 'package:ttc_workshop_2/forms/addCrochetHook.dart';
import 'package:ttc_workshop_2/forms/addCrochetThread.dart';
import 'package:ttc_workshop_2/forms/addKnittingNeedle.dart';
import 'package:ttc_workshop_2/forms/addYarn.dart';
import 'package:ttc_workshop_2/tabs/crochetHook_tab.dart';
import 'package:ttc_workshop_2/tabs/knittingneedles_tab.dart';
import 'package:ttc_workshop_2/tabs/yarn_tab.dart';
import '../drawer.dart';
import 'package:ttc_workshop_2/models/crochetthread_model.dart';
import '../tabs/crochetthread_tab.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class ThreadHook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: ChangeNotifierProvider(
          create: (BuildContext context) => CrochetThreadTab(),
          child: Scaffold(
            backgroundColor: const Color(0xffE9DCE5),
            appBar: AppBar(
              backgroundColor: const Color(0xff693b58),
              foregroundColor: Colors.white,
              title: const Text('Yarns, Hooks, etc.'),
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Crochet Thread'),
                  Tab(text: 'Yarn'),
                  Tab(text: 'Crochet Hooks'),
                  Tab(text: 'Knitting Needles'),
                ],
              ),
            ),
            body: ThreadsTabBar(),
            drawer: MyDrawer(),
            floatingActionButton: SpeedDial(
              //Speed dial menu
              icon: Icons.menu, //icon on Floating action button
              activeIcon: Icons.close, //icon when menu is expanded on button
              backgroundColor:
                  const Color(0xff997ABD), //background color of button
              foregroundColor: Colors.black, //font color, icon color in button
              activeBackgroundColor: const Color(
                  0xff997ABD), //background color when menu is expanded
              activeForegroundColor: Colors.black12,
              buttonSize: 56.0, //button size
              visible: true,
              closeManually: false,
              curve: Curves.bounceIn,
              elevation: 8.0, //shadow elevation of button
              shape: CircleBorder(), //shape of button

              children: [
                SpeedDialChild(
                  child: Icon(Icons.add),
                  backgroundColor: const Color(0xff540E32),
                  foregroundColor: Colors.white,
                  label: 'Add Crochet Thread',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCrochetThread()),
                    );
                  },
                ),
                SpeedDialChild(
                  //speed dial child
                  child: Icon(Icons.add),
                  backgroundColor: const Color(0xff540E32),
                  foregroundColor: Colors.white,
                  label: 'Add Yarn',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddYarn()),
                    );
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.add),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff540E32),
                  label: 'Add Crochet Hook',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCrochetHook()),
                    );
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.add),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff540E32),
                  label: 'Add Knitting Needle',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddKnittingNeedle()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThreadsTabBar extends StatefulWidget with ChangeNotifier {
  @override
  _ThreadsTabBarState createState() {
    return _ThreadsTabBarState();
  }
}

class _ThreadsTabBarState extends State<ThreadsTabBar> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      CrochetThreadTab(),
      YarnTab(),
      CrochetHookTab(),
      KnittingNeedleTab(),
    ]);
  }
}
