import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/cards/crochetHookCard.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';
import 'package:ttc_workshop_2/models/crochethook_model.dart';

class CrochetHookTab extends StatefulWidget {
  @override
  _CrochetHookTabState createState() {
    return _CrochetHookTabState();
  }
}

class _CrochetHookTabState extends State<CrochetHookTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getCrochetHook(),
      builder: (context, AsyncSnapshot<List<CrochetHookModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              CrochetHookModel _model = snapshot.data![index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[350],
                    radius: 30,
                    //child: Image.asset('images/default_image.png'),
                  ),
                  title: Text(_model.hookSize),
                  trailing: Text(_model.hookType),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CrochetHook()),
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
          child: Text('No Crochet Hook added'),
        );
      },
    );
  }
}
