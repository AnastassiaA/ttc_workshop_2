import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';
import 'package:ttc_workshop_2/drawer_contents/yarnthreadthings.dart';
import 'package:ttc_workshop_2/models/crochethook_model.dart';
import 'package:ttc_workshop_2/models/crochetthread_model.dart';
import 'package:ttc_workshop_2/models/yarn_model.dart';

class AddCrochetHook extends StatefulWidget {
  @override
  _AddCrochetHookState createState() => _AddCrochetHookState();
}

class _AddCrochetHookState extends State<AddCrochetHook> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'None';

  //final crochetHookNumberController = TextEditingController();

  final hookSizeController = TextEditingController();

  final hookTypeController = TextEditingController();

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

    //crochetHookNumberController.dispose();

    hookSizeController.dispose();

    hookTypeController.dispose();
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
          title: Text('Add Crochet Hook'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: hookSizeController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Hook Size',
                    ),
                  ),
                  TextFormField(
                    controller: hookTypeController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Hook Type',
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
                                  content: Text('Saving crochet hook')));

                          await DatabaseHelper.instance.addCrochetHook(
                            CrochetHookModel(
                              hookSize: hookSizeController.text,
                              hookType: hookTypeController.text,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThreadHook()),
                          );
                        },
                        child: Text("add crochet hook"),
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
