import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/cards/crochetHookCard.dart';
import 'package:ttc_workshop_2/cards/knittingNeedleCard.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';
import 'package:ttc_workshop_2/models/crochethook_model.dart';
import 'package:ttc_workshop_2/models/knttingneedles_model.dart';

class KnittingNeedleTab extends StatefulWidget {
  @override
  _KnittingNeedleTabState createState() {
    return _KnittingNeedleTabState();
  }
}

class _KnittingNeedleTabState extends State<KnittingNeedleTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getKnittingNeedle(),
      builder: (context, AsyncSnapshot<List<KnittingNeedleModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              KnittingNeedleModel _model = snapshot.data![index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[350],
                    radius: 30,
                    //child: Image.asset('images/default_image.png'),
                  ),
                  title: Text(_model.knittingNeedleSize),
                  trailing: Text(_model.knittingNeedleType),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KnittingNeedle()),
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
          child: Text('No Knitting Needles added'),
        );
      },
    );
  }
}
