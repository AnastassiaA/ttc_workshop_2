import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ttc_workshop_2/models/expense_model.dart';

class ExpenseDatabase {
  static final ExpenseDatabase instance = ExpenseDatabase._init();

  static Database? _database;

  ExpenseDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initializeDB('TTwineCommissions.sql');
    return _database!;
  }

  Future<Database> _initializeDB(String filePath) async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, filePath);

    return await openDatabase(path, version: 1);
  }

  //Future _createDB(Database dataB, int version) async {}

  Future close() async {
    final dataB = await instance.database;

    dataB?.close();
  }
}

class ExpenseDatabasehelper {
  Future main() async {
    WidgetsFlutterBinding.ensureInitialized();

    final database =
        openDatabase(join(await getDatabasesPath(), 'TTwineCommissions.sql'));

    //add
    Future<void> insertExpense(Expense expense) async {
      final db = await database;

      await db.insert(
        'Expenses',
        expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future calculateTotal() async {
      var dbClient = await database;
      var result =
          await dbClient.rawQuery("SELECT SUM(Price) as Total FROM Expenses");
      //print(result.toList());
      final count = Sqflite.firstIntValue(result);
    }

    // A method that retrieves all the expenses from the expense table.
    Future<List<Expense>> getExpenses() async {
      // Get a reference to the database.
      final db = await database;

      // Query the table for all The Expenses.
      final List<Map<String, dynamic>> maps = await db.query('Expenses');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return Expense(
            expenseid: maps[i]['ExpenseID'],
            expensename: maps[i]['Expense Name'],
            date: maps[i]['Date'],
            type: maps[i]['Type'],
            amount: maps[i]['Amount'],
            price: maps[i]['Price']);
      });
    }

    Future<void> updateExpense(Expense expense) async {
      // Get a reference to the database.
      final db = await database;

      // Update the given expense.
      await db.update(
        'Expenses',
        expense.toMap(),
        // Ensure that the expense has a matching id.
        where: 'expenseid = ?',
        // Pass the expense's id as a whereArg to prevent SQL injection.
        whereArgs: [expense.expenseid],
      );
    }

    Future<void> deleteExpense(int expenseid) async {
      // Get a reference to the database.
      final db = await database;

      // Remove the Dog from the database.
      await db.delete(
        'Expenses',
        // Use a `where` clause to delete a specific expense.
        where: 'expenseid = ?',
        // Pass the expense's id as a whereArg to prevent SQL injection.
        whereArgs: [expenseid],
      );
    }
  }
}
