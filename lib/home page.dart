import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/order.dart';
import 'drawer.dart';
import 'package:ttc_workshop_2/db_code/db_expense.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
  // late Future<int> _totalExpense = Future<String>.delayed(
  //   const Duration(seconds: 2),
  //   () => 'Loading',
  // ) as Future<int>;

  // @override
  // initState() {
  //   super.initState();
  //   _totalExpense = Dbhelper.main().calculateTotal();
  // }

  //or?

  final databHelper = ExpenseDatabasehelper().main();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff78184A),
          foregroundColor: Colors.white,
          //shape: ShapeBorder.lerp(a, b, t),
          title: const Text('TTC Workshop'),
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
                  MaterialPageRoute(builder: (context) => AddOrder()),
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
                  MaterialPageRoute(builder: (context) => AddOrder()),
                );
              },
              icon: Icon(Icons.add),
              label: Text('ORDERS'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ExpenseAndRevenueChart(data: data),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 70.0,
                      child: Card(
                        //color: const Color(0xff78184A),
                        child: Column(
                          children: [
                            Text('Expense'),
                            // FutureBuilder<int>(
                            //   future: _totalExpense,
                            //   builder: (ex, snapshot) {},
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 70.0,
                      child: Card(child: Text('Revenue')),
                    ),
                  ),
                  //SizedBox(),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 70.0,
                      child: Card(child: Text('Orders In Progress')),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 70.0,
                      child: Card(child: Text('Orders Pending')),
                    ),
                  ),
                  //SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<ExpenseAndRevenue> data = [
    ExpenseAndRevenue(
      type: "Expense",
      amount: 10000, //TODO get this from database
      barColor: charts.ColorUtil.fromDartColor(const Color(0xff67032F)),
      //charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ExpenseAndRevenue(
      type: "Revenue",
      amount: 15000, //TODO get this from database
      barColor: charts.ColorUtil.fromDartColor(const Color(0xffE0B0FF)),
    ),
  ];
}

class ExpenseAndRevenue {
  final String type;
  final double amount;
  final charts.Color barColor;

  ExpenseAndRevenue(
      {required this.type, required this.amount, required this.barColor});
}

class ExpenseAndRevenueChart extends StatelessWidget {
  final List<ExpenseAndRevenue> data;

  ExpenseAndRevenueChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ExpenseAndRevenue, String>> series = [
      charts.Series(
        id: "Expense and Revenue",
        data: data,
        domainFn: (ExpenseAndRevenue series, _) => series.type,
        measureFn: (ExpenseAndRevenue series, _) => series.amount,
        colorFn: (ExpenseAndRevenue series, _) => series.barColor,
      )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: <Widget>[
            Text(
              "How Things Are Going",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Expanded(child: charts.BarChart(series, animate: true))
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
