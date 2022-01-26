import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ttc_workshop_2/models/crochetthread_model.dart';

class CrochetThreadDatabaseHelper extends ChangeNotifier {
  //CrochetThreadDatabase.ensureInitialized();

  CrochetThreadDatabaseHelper._privateConstructor();

  static final CrochetThreadDatabaseHelper instance =
      CrochetThreadDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), 'ttwinecommissions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE crochetthread(
      threadNumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      threadcolor TEXT,  
      brand TEXT,
      material TEXT,
      size TEXT,
      availableweight REAL,
      pricepergram REAL,
      weight REAL,
      recchookneedle TEXT,
      cost REAL
    )''');
  }

  Future<void> addCrochetThread(CrochetThreadModel crochetThread) async {
    Database db = await instance.database;

    await db.insert(
      'crochetthread',
      crochetThread.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<CrochetThreadModel>> getCrochetThread() async {
    Database db = await instance.database;

    var crochetThread = await db.query('crochetthread');

    List<CrochetThreadModel> crochetThreadList = crochetThread.isNotEmpty
        ? crochetThread.map((e) => CrochetThreadModel.fromMap(e)).toList()
        : [];
    notifyListeners();
    return crochetThreadList;
  }

  Future<void> updateCrochetThread(CrochetThreadModel crochetThread) async {
    final db = await database;

    await db.update(
      'crochetthread',
      crochetThread.toMap(),
      where: 'threadnumber = ?',
      whereArgs: [
        ['threadnumber']
      ], // Pass the id as a whereArg to prevent SQL injection.
    );
    notifyListeners();
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
    notifyListeners();
  }
}
