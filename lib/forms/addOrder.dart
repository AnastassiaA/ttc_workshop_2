import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttc_workshop_2/db_code/databaseUtilities.dart';
import 'package:ttc_workshop_2/models/order_model.dart';

class AddOrderForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddOrderState();
  }
}

class AddOrderState extends State<AddOrderForm> {
  final _formKey = GlobalKey<FormState>();

  final orderNameController = TextEditingController();
  final customerContactController = TextEditingController();
  final craftTypeController = TextEditingController();
  final statusController = TextEditingController();
  final descriptionController = TextEditingController();

  String dropdownValue = 'None';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          title: Text('Add Orders'),
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
                    controller: orderNameController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  TextFormField(
                    controller: customerContactController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Customer Contact',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  TextFormField(
                    controller: craftTypeController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Craft Type',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  TextFormField(
                    controller: statusController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      //TODO: dropdown menu
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saving order')));

                            await DatabaseHelper.instance.addOrder(
                              OrderModel(
                                  description: descriptionController.text,
                                  status: statusController.text,
                                  customer: customerContactController.text,
                                  orderName: orderNameController.text,
                                  craftType: craftTypeController.text),
                            );

                            Navigator.pop(context);
                          },
                          child: Text("add order"),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String generateOrderNumber(String typeChoice) {
    Random random = new Random();
    int number = random.nextInt(1000000);

    String typeLetter = typeChoice.substring(0, 1);

    String orderNumber = typeLetter + number.toString().padLeft(6, '0');

    return orderNumber;
  }
}
