import 'package:flutter/material.dart';
import 'package:dp_stopwatch/dp_stopwatch.dart';

class ItemTimer extends StatefulWidget {
  @override
  _ItemTimerState createState() => _ItemTimerState();
}

class _ItemTimerState extends State<ItemTimer> {
  final workStopwatchViewModel = DPStopwatchViewModel(
    clockTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 50,
    ),
  );

  //TODO: Timer stays on when not on screen
  //TODO: Timer shows h:m:s instead of m:s:ms
  //TODO: Dropdown menu for in progress or pending orders
  //TODO: Note what time the timer started

  bool start = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff36454F),
        //foregroundColor: Colors.white,
        //shape: ShapeBorder.lerp(a, b, t),
        //title: const Text('TTC Workshop'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: const Color(0xff3e505c),
                height: MediaQuery.of(context).size.height * 0.33,
              ),
              Container(
                color: const Color(0xff36454f),
                height: MediaQuery.of(context).size.height * 0.55,
              ),
            ],
          ),
          Positioned(
            // top: MediaQuery.of(context).size.height * 0.10, //120,
            // left: MediaQuery.of(context).size.width * 0.30, //50,
            //bottom: 50,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width * 0.90,
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.white)),
                      child: Center(
                        child: DPStopWatchWidget(
                          workStopwatchViewModel,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  //color: const Color(0xff997ABD),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Text(
                    'Timer (started at x:xx pm)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  //color: const Color(0xff997ABD),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Text(
                    'Project name (dropdown)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  //todo: before a timer starts, there is only one button, labeled START
                  //todo: after a timer starts, there ar two buttons, PAUSE and STOP
                  //TODO: on pausing a timer, PAUSE becomes STOP

                  //color: const Color(0xff997ABD),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: TextButton(
                    //start button
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if (start == false) {
                        workStopwatchViewModel.start?.call();
                        start = true;

                        setState(() {
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    workStopwatchViewModel.pause?.call();
                                  },
                                  child: const Text('PAUSE'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    workStopwatchViewModel.stop?.call();
                                  },
                                  child: const Text('stop'),
                                ),
                              ],
                            ),
                          );
                        });
                      }
                    },
                    child: const Text('START'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
