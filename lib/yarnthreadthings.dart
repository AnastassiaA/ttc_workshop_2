import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ttc_workshop_2/db_code/crochetthread_db.dart';
import 'drawer.dart';
import 'package:ttc_workshop_2/models/crochetthread_model.dart';
import 'crochetthread_tab.dart';

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
                      MaterialPageRoute(
                          builder: (context) => AddCrochetThread()),
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
      Icon(Icons.directions_transit),
      Icon(Icons.directions_bike),
      Icon(Icons.directions_bike),
    ]);
  }
}

class AddCrochetThread extends StatefulWidget {
  @override
  _AddCrochetThreadState createState() => _AddCrochetThreadState();
}

class _AddCrochetThreadState extends State<AddCrochetThread> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'None';

  //final threadNumberController = TextEditingController();

  final threadColorController = TextEditingController();

  final brandController = TextEditingController();

  final materialController = TextEditingController();

  final sizeController = TextEditingController();

  final availableWeightController = TextEditingController();

  final priceController = TextEditingController();

  final weightController = TextEditingController();

  final hooknNeedleController = TextEditingController();

  final costController = TextEditingController();

  TextEditingController _controller = TextEditingController();

  bool _loadingPath = false;
  String? _directoryPath;
  List<PlatformFile>? _paths;
  String? _extension;
  String? _fileName;
  FilePickerResult? pickedFile;
  int index = 0;
  late final path;

  // String _generateThreadNumber(String threadColor) {
  //   Random random = new Random();
  //   int number = random.nextInt(10);
  //
  //   String color = threadColor.substring(0, 3).toUpperCase();
  //
  //   String threadNumber = color + number.toString().padLeft(4, '0');
  //   return threadNumber;
  // }

  void dispose() {
    super.dispose();

    //threadNumberController.dispose();

    threadColorController.dispose();

    brandController.dispose();

    materialController.dispose();

    sizeController.dispose();

    availableWeightController.dispose();

    priceController.dispose();

    weightController.dispose();

    hooknNeedleController.dispose();

    costController.dispose();
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;

      // String img = _paths!.first.path.toString();
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  Widget printText() {
    if (_fileName == null) {
      return Text('');
    } else {
      return Text('$_fileName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          title: Text('Add Crochet Thread'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // TextField(
                  //   controller: threadNumberController,
                  //   showCursor: true,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Thread Number',
                  //   ),
                  // ),
                  TextFormField(
                    controller: threadColorController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Thread Color',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  Container(
                    child: printText(),
                    // Image.file(
                    //     io.File(
                    //       _paths!.first.path.toString(),
                    //     ),
                    //     width: 100,
                    //     height: 100,
                    //     fit: BoxFit.fill)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _openFileExplorer();
                        path = _paths!
                            .map((e) => e.path)
                            .toList()[index]
                            .toString();
                      },
                      child: Card(
                        color: const Color(0xffE9DCE5),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.camera_alt,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.image),
                            ),
                            Text('IMAGE', textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: brandController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                    ),
                  ),
                  TextFormField(
                    controller: materialController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Material',
                    ),
                  ),
                  TextFormField(
                    controller: sizeController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Size',
                    ),
                  ),
                  TextFormField(
                    controller: availableWeightController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Available Weight (g)',
                    ),
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Price per gram',
                    ),
                  ),
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                    ),
                  ),
                  TextFormField(
                    controller: hooknNeedleController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Recc Hook/Needle',
                    ),
                  ),
                  TextFormField(
                    controller: costController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Cost',
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        //style: ,
                        onPressed:
                            //TODO: Refresh list tile on pressed
                            () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Saving crochet thread')));

                          await CrochetThreadDatabaseHelper.instance
                              .addCrochetThread(
                            CrochetThreadModel(
                              //threadNumber: threadNumberController.text,
                              threadColor: threadColorController.text,
                              //image: path,
                              brand: brandController.text,
                              material: materialController.text,
                              size: sizeController.text,
                              availableWeight:
                                  double.parse(availableWeightController.text),
                              pricePerGram: double.parse(priceController.text),
                              weight: double.parse(weightController.text),
                              reccHookNeedle: hooknNeedleController.text,
                              cost: double.parse(costController.text),
                            ),
                          );

                          // setState(() {
                          //   threadNumberController.clear();
                          //   threadColorController.clear();
                          //   path.clear();
                          //   brandController.clear();
                          //   materialController.clear();
                          //   sizeController.clear();
                          //   availableWeightController.clear();
                          //   priceController.clear();
                          //   weightController.clear();
                          //   hooknNeedleController.clear();
                          //   costController.clear();
                          // });

                          Navigator.pop(context);
                        },
                        child: Text("add thread"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
