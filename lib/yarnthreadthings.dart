import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
                Tab(text: 'Crochet Thread'),
                Tab(text: 'Yarn'),
                Tab(text: 'Crochet Hooks'),
                Tab(text: 'Knitting Needles'),
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
                //speed dial child
                child: Icon(Icons.add),
                backgroundColor: const Color(0xff540E32),
                foregroundColor: Colors.white,
                label: 'Add Yarn',
                labelStyle: TextStyle(fontSize: 18.0),
              ),
              SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: const Color(0xff540E32),
                foregroundColor: Colors.white,
                label: 'Add Crochet Thread',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCrochetThread()),
                  );
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.add),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff540E32),
                label: 'Add Crochet Hook',
                labelStyle: TextStyle(fontSize: 18.0),
              ),
              SpeedDialChild(
                child: Icon(Icons.add),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff540E32),
                label: 'Add Knitting Needle',
                labelStyle: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddCrochetThread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff540E32),
          title: Text('Add Crochet Thread'),
        ),
        body: AddCrochetThreadForm(),
      ),
    );
  }
}

class AddCrochetThreadForm extends StatefulWidget {
  @override
  _AddCrochetThreadState createState() {
    return _AddCrochetThreadState();
  }
}

class _AddCrochetThreadState extends State<AddCrochetThreadForm> {
  String _threadNumber = '';
  String _threadColor = '';
  String _image = '';
  String _brand = '';
  String _material = '';
  String _size = '';
  double _availableWeight = 0.0;
  double _pricePerGram = 0.0;
  String _weight = '';
  String _reccHookNeedle = '';
  double _cost = 0.0;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'None';
  final brandName = TextEditingController();
  List<String> dropdownList = ['None', "Auntie Lydia's"];
  final _threadNumberController = TextEditingController();

  @override
  void threadDispose() {
    _threadNumberController.dispose();

    super.dispose();
  }

  String _generateThreadNumber(String threadColor) {
    Random random = new Random();
    int number = random.nextInt(10);

    String color = threadColor.substring(0, 3).toUpperCase();

    String threadNumber = color + number.toString().padLeft(4, '0');
    return threadNumber;
  }

  @override
  void brandDispose() {
    // Clean up the controller when the widget is disposed.
    brandName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _threadNumberController,
                showCursor: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Thread Number',
                ),
                readOnly: true,
              ),
              TextFormField(
                onChanged: (text) {
                  _threadNumberController.text = _generateThreadNumber(text);
                },
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Thread Color',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter thread color';
                  }
                  return null;
                },
              ),
              TextFormField(
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Image',
                ),
              ),
              Row(
                children: [
                  Text('Brand'),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: dropdownList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Alert(
                            context: context,
                            title: "Add brand",
                            content: Column(
                              children: <Widget>[
                                Container(
                                  child: TextField(
                                    controller: brandName,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Brand',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                onPressed: () {
                                  setState(() {
                                    dropdownList.add(brandName.text);
                                  });
                                },
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ]).show();
                      },
                      icon: Icon(Icons.add)), //add a new brand
                ],
              ),
              TextFormField(
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Material',
                ),
              ),
              TextFormField(
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Size',
                ),
              ),
              TextFormField(
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Available Weight',
                ),
              ),
              TextFormField(
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Price per gram',
                ),
              ),
              TextFormField(
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                ),
              ),
              TextFormField(
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Recc Hook/Needle',
                ),
              ),
              TextFormField(
                showCursor: true,
                decoration: const InputDecoration(
                  labelText: 'Cost',
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    child: const Text('Add Thread'),
                    onPressed: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//================================//
//My Attempt at reverse engineering
//=========//
// class StackedFAB extends StatefulWidget {
//   const StackedFAB({
//     Key? key,
//     this.initialOpen,
//     required this.children,
//   });
//
//   final bool? initialOpen;
//   final List<Widget> children;
//
//   @override
//   _StackedFABState createState() {
//     return _StackedFABState();
//   }
// }
//
// class _StackedFABState extends State<StackedFAB>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _expandAnimation;
//   bool _open = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _open = widget.initialOpen ?? false;
//     _controller = AnimationController(
//       value: _open ? 1.0 : 0.0,
//       duration: const Duration(milliseconds: 250),
//       vsync: this,
//     );
//     _expandAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _toggle() {
//     setState(() {
//       _open = !_open;
//       if (_open) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         clipBehavior: Clip.none,
//         children: [
//           _buildTapToCloseStackedFab(),
//           ..._buildExpandingActionButtons(),
//           _buildTapToOpenFab(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTapToCloseStackedFab() {
//     return SizedBox(
//       width: 56.0,
//       height: 56.0,
//       child: Center(
//         child: Material(
//           shape: const CircleBorder(),
//           clipBehavior: Clip.antiAlias,
//           elevation: 4.0,
//           child: InkWell(
//             onTap: _toggle,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(
//                 Icons.close,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildExpandingActionButtons() {
//     final children = <Widget>[];
//     final count = widget.children.length;
//
//     for (var i = 0; i < count; i++) {
//       children.add(_StackedFAB);
//     }
//     return children;
//   }
// }
//=========================================//
