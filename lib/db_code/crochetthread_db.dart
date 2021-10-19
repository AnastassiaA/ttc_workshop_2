import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:ttc_workshop_2/models/crochetthread_model.dart';

class CrochetThreadDatabase {
  CrochetThreadDatabase.ensureInitialized();

  get database => openDB();

  void openDB() async {
    //remember to pair your await with an async
    final database = openDatabase(
      join(await getDatabasesPath(), 'ttwinecommissions.db'), //FutureBuilder?

      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE crochetthread(threadnumber TEXT PRIMARY KEY, threadcolor TEXT, image TEXT, brand TEXT, material TEXT, size TEXT, availableweight REAL, pricepergram REAL,weight REAL, recchookneedle REAL, cost REAL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertCrochetThread(CrochetThreadModel crochetThread) async {
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'crochetthread',
      crochetThread.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CrochetThreadModel>> crochetThread() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('crochetthread');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return CrochetThreadModel(
        threadNumber: maps[i]['threadnumber'],
        threadColor: maps[i]['threadcolor'],
        image: maps[i]['image'],
        brand: maps[i]['brand'],
        material: maps[i]['material'],
        size: maps[i]['size'],
        availableWeight: maps[i]['availableweight'],
        pricePerGram: maps[i]['pricepergram'],
        weight: maps[i]['weight'],
        reccHookNeedle: maps[i]['recchookneedle'],
        cost: maps[i]['cost'],
      );
    });
  }

  Future<void> updateCrochetThread(CrochetThreadModel crochetThread) async {
    final db = await database;

    await db.update(
      'crochetthread',
      crochetThread.toMap(),
      where: 'threadnumber = ?',
      whereArgs: [
        crochetThread.threadNumber
      ], // Pass the id as a whereArg to prevent SQL injection.
    );
  }

  Future<void> deleteCrochetThread(String threadNumber) async {
    final db = await database;

    await db.delete(
      'crochetthread',
      where: 'threadnumber = ?',
      whereArgs: [
        threadNumber
      ], // Pass the id as a whereArg to prevent SQL injection.
    );
  }
}
