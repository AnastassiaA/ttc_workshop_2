import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';

import '../cards/crochetThreadCard.dart';
import '../models/crochetthread_model.dart';

class CrochetThreadTab extends StatefulWidget with ChangeNotifier {
  @override
  _CrochetThreadTabState createState() {
    return _CrochetThreadTabState();
  }
}

class _CrochetThreadTabState extends State<CrochetThreadTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getCrochetThread(),
      builder: (context, AsyncSnapshot<List<CrochetThreadModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              CrochetThreadModel _model = snapshot.data![index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[350],
                    radius: 30,
                    //child: Image.asset('images/default_image.png'),
                  ),
                  title: Text(_model.threadColor),
                  subtitle: Text(_model.brand),
                  trailing: Text(_model.availableWeight.toString() + ' g'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CrochetThread(),
                    ),
                  ),
                ),
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                //margin: ,
              );
            },
          );
        }
        return Center(
          child: Text('No Crochet Thread added'),
        );
      },
    );
  }
}
