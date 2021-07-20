import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class ThreadHook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Yarns, Hooks, etc.'),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.green[400],
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.green[400],
            icon: Icon(Icons.waves_sharp),
            label: 'Thread',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green[400],
            icon: Icon(Icons.waves_outlined),
            label: 'Yarn',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green[400],
            icon: Icon(Icons.anchor_outlined),
            label: 'Hooks',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green[400],
            icon: Icon(Icons.architecture_outlined),
            label: 'Needles',
          )
        ],
      ),
    );
  }
}
