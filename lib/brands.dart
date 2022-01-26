import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Brand extends StatelessWidget {
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
            title: const Text('Brands'),
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
          body: TabBarView(children: [
            ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Auntie Lydia's"), //${brandName}
                  subtitle: Text("Crochet Thread"), //${threadType}
                  onTap: () {},
                );
              },
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
          ]),
        ),
      ),
    );
  }
}
