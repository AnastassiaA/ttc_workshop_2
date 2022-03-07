import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/drawer_contents/orderHome.dart';
import 'db_code/databaseUtilities.dart';
import 'drawer.dart';
import 'package:ttc_workshop_2/db_code/db_expense.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'expenses.dart';
import 'forms/addOrder.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

@immutable
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final databHelper = ExpenseDatabasehelper().main();
  int number = 0;

  void countOrders() async {
    int? count = await DatabaseHelper.instance.numberOfOrders();

    setState(() {
      number = count;
    });

    print(number);
  }

  @override
  void initState() {
    super.initState();
    countOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff693b58),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          //foregroundColor: Colors.white,
          //shape: ShapeBorder.lerp(a, b, t),
          //title: const Text('Dont Delete App'),
        ),
        drawer: MyDrawer(),
        floatingActionButton: ExpandableFab(
          distance: 115.0,
          children: [
            FloatingActionButton.extended(
              heroTag: "ExpenseButton",
              backgroundColor: const Color(0xff997ABD),
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpenseForm()),
                );
              },
              icon: Icon(Icons.add),
              label: Text('EXPENSE'),
            ),
            FloatingActionButton.extended(
              heroTag: "OrderButton",
              backgroundColor: const Color(0xff997ABD),
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddOrderForm()),
                );
              },
              icon: Icon(Icons.add),
              label: Text('ORDERS'),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //ExpenseAndRevenueChart(data: data),
            Row(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child:
                              Text('$number', style: TextStyle(fontSize: 70)),
                        ),
                        Text('Orders Pending'),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Card(
                        child: Row(
                          children: [
                            Icon(Icons.account_balance_wallet_rounded),
                            Icon(Icons.attach_money),
                            Text('Business wallet'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Card(
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: Colors.green,
                              ),
                              Text('[Sales]'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.47,
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: Colors.red,
                            ),
                            Text('[Expense]')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //SizedBox(),
              ],
            ),

            // Container(
            //   height: MediaQuery.of(context).size.height * 0.48,
            //   child: CarouselSlider(
            //     items: [
            //       Container(
            //         child: Card(
            //           child: Container(
            //               width: MediaQuery.of(context).size.width * 1,
            //               child: Text('Android')),
            //         ),
            //       ),
            //       Container(
            //         child: Card(
            //           child: Container(
            //               width: MediaQuery.of(context).size.width * 1,
            //               child: Text('iOS')),
            //         ),
            //       ),
            //       Container(
            //         child: Card(
            //           child: Container(
            //               width: MediaQuery.of(context).size.width * 1,
            //               child: Text('Desktop')),
            //         ),
            //       ),
            //       Container(
            //         child: Card(
            //           child: Container(
            //               width: MediaQuery.of(context).size.width * 1,
            //               child: Text('Web')),
            //         ),
            //       )
            //     ],
            //
            //     //Slider Container properties
            //     options: CarouselOptions(
            //       autoPlay: false,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                //color: Color(0xff03dac6),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: const Color(0xff997ABD),
            onPressed: _toggle,
            child: const Icon(
              Icons.create,
              //color: Color(0xff03dac6),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
