import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../brands.dart';
import '../drawer.dart';

class MiscInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Misc Info'),
        ),
        drawer: MyDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('Brands'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Brand()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Sellers'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
