import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'order.dart';

class ThreadHook extends StatelessWidget {
  final items = List<String>.generate(20, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          backgroundColor: const Color(0xffE9DCE5),
          appBar: AppBar(
            backgroundColor: const Color(0xff540E32),
            foregroundColor: Colors.white,
            title: const Text('Yarns, Hooks, etc.'),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Crochet Hooks'),
                Tab(text: 'Knitting Needles'),
                Tab(text: 'Yarn'),
                Tab(text: 'Crochet Thread'),
              ],
            ),
          ),
          body: TabBarView(children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${items[index]}'),
                );
              },
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
          ]),
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff997ABD),
            foregroundColor: Colors.black,
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddOrder()),
              // );
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
