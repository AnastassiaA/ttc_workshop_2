import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Brand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff78184A),
          foregroundColor: Colors.white,
          title: const Text('Brands'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Auntie Lydia's"), //${brandName}
                subtitle: Text("Crochet Thread"), //${threadType}
                onTap: () {},
              ),
            ),
            // Card(
            //   child: ListTile(
            //     title: Text('Sellers'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
