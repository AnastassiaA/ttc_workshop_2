import 'package:flutter/material.dart';
import 'drawer.dart';
import 'dart:math';
//===============================================//

class Order {
  String orderNum = '';
  String orderName = '';
  String customerName = '';
  String craftType = ''; //knit or crochet
  String status = '';
}

class OrderHome extends StatelessWidget {
  final items = List<String>.generate(20, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff720058),
          foregroundColor: Colors.white,
          title: const Text('Orders'),
        ),
        drawer: MyDrawer(),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffceb98e),
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddOrder()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

//===============================================//

class AddOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Order'),
      ),
      body: AddOrderForm(),
    );
  }
}

class AddOrderForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddOrderState();
  }
}

class AddOrderState extends State<AddOrderForm> {
  int _orderNum = 0;
  String _orderName = '';
  String _customerName = ''; //TODO pull from contacts
  String _craftType = ''; //knit or crochet
  String _tool =
      ''; //which crochet hook or knitting needle, be able to add multiple
  String _thread = ''; //crochet or yarn, be able to add multiple
  String _projectTimer = ''; //TODO stopwatch
  double _rate = 0.0;
  String _description = '';
  String _picture = ''; //TODO figure out how to do picture stuff
  String _crochetHook = ''; //TODO make an object of type crochet hook

  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'None';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Customer Name'),
              autofocus: true,
            ),
          ),
          Container(
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['None', 'Knit', 'Crochet']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Tool'),
              autofocus: true,
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Thread'),
              autofocus: true,
            ),
          ),
        ],
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

//===============================================//
