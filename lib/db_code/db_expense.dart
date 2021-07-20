import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ttc_workshop_2/models/model_expense.dart';

class ExpenseDatabasehelper {
  Future main() async {
    WidgetsFlutterBinding.ensureInitialized();

    final database =
        openDatabase(join(await getDatabasesPath(), 'TTwineCommissions.db'));

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
