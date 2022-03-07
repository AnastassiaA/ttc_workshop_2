import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/cards/yarnCard.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';
import 'package:ttc_workshop_2/models/yarn_model.dart';

class YarnTab extends StatefulWidget {
  @override
  _YarnTabState createState() {
    return _YarnTabState();
  }
}

class _YarnTabState extends State<YarnTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getYarn(),
      builder: (context, AsyncSnapshot<List<YarnModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              YarnModel _model = snapshot.data![index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[350],
                    radius: 30,
                    //child: Image.asset('images/default_image.png'),
                  ),
                  title: Text(_model.yarnColor),
                  subtitle: Text(_model.brand),
                  trailing: Text(_model.availableWeight.toString() + ' g'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Yarn(),
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
          child: Text('No Yarn added'),
        );
      },
    );
  }
}
