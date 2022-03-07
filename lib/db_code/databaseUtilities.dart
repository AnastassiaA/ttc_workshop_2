import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ttc_workshop_2/models/crochethook_model.dart';
import 'package:ttc_workshop_2/models/crochetthread_model.dart';
import 'package:ttc_workshop_2/models/knttingneedles_model.dart';
import 'package:ttc_workshop_2/models/order_model.dart';
import 'package:ttc_workshop_2/models/yarn_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

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
    //---ORDERS TABLE---//
    await db.execute(
        '''CREATE TABLE orders(ordernumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ordername TEXT,
      crafttype TEXT,
      customer TEXT,
      status TEXT,
      description TEXT
      )''');

    //--EXPENSE TABLE--//

    //--CROCHET THREAD TABLE--//
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

    //--YARN TABLE--//
    await db.execute('''CREATE TABLE yarn(
    yarnnumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    yarncolor TEXT,
    brand TEXT,
    material TEXT,
    size TEXT,
    availableweight REAL,
    pricepergram REAL,
    weight REAL,
    recchookneedle TEXT,
    cost REAL)''');

    //--CROCHETHOOK TABLE--//
    await db.execute('''
    CREATE TABLE crochethook(
    crochethooknumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    hooksize TEXT,
    hooktype  TEXT)
    ''');

    //--KNITTING NEEDLE TABLE--//
    await db.execute('''
    CREATE TABLE knittingneedle(
    knittingneedlenumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    knittingneedlesize TEXT,
    knittingneedletype  TEXT)
    ''');
  }

  //---------KNITTING NEEDLE DB FUNCTIONS---------//
  Future<void> addKnittingNeedle(KnittingNeedleModel needle) async {
    Database db = await instance.database;

    await db.insert('knittingneedle', needle.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<KnittingNeedleModel>> getKnittingNeedle() async {
    Database db = await instance.database;

    var knittingNeedle = await db.query('knittingneedle');

    List<KnittingNeedleModel> needleList = knittingNeedle.isNotEmpty
        ? knittingNeedle.map((e) => KnittingNeedleModel.fromMap(e)).toList()
        : [];
    return needleList;
  }

  Future<void> updateKnittingNeedle(KnittingNeedleModel needle) async {
    final db = await database;

    await db.update(
      'knittingneedle',
      needle.toMap(),
      where: 'knittingneedlenumber = ?',
      whereArgs: [
        ['knittingneedlenumber'],
      ],
    );
  }

  Future<void> deleteKnittingNeedle(String knittingNeedleSize) async {
    final db = await database;

    await db.delete('knittingneedle',
        where: 'knittingneedlenumber = ?',
        whereArgs: [
          ['knittingneedlenumber']
        ]);
  }

  //---------CROCHET HOOK DB FUNCTIONS---------//
  Future<void> addCrochetHook(CrochetHookModel hook) async {
    Database db = await instance.database;

    await db.insert('crochethook', hook.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<CrochetHookModel>> getCrochetHook() async {
    Database db = await instance.database;

    var crochetHook = await db.query('crochethook');

    List<CrochetHookModel> hookList = crochetHook.isNotEmpty
        ? crochetHook.map((e) => CrochetHookModel.fromMap(e)).toList()
        : [];
    return hookList;
  }

  Future<void> updateCrochetHook(CrochetHookModel hook) async {
    final db = await database;

    await db.update(
      'crochethook',
      hook.toMap(),
      where: 'crochethooknumber = ?',
      whereArgs: [
        ['crochethooknumber'],
      ],
    );
  }

  Future<void> deleteCrochetHook(String hookSize) async {
    final db = await database;

    await db.delete('crochethook', where: 'crochethooknumber = ?', whereArgs: [
      ['crochethooknumber']
    ]);
  }

  //---------ORDER DB FUNCTIONS---------//
  Future<void> addOrder(OrderModel order) async {
    Database db = await instance.database;

    await db.insert('orders', order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> numberOfOrders() async {
    final db = await database;

    final numOrders;

    final count = await db
        .rawQuery('SELECT COUNT(*) FROM orders WHERE status LIKE "%pending%"');

    numOrders = Sqflite.firstIntValue(count);

    print('total orders = $numOrders');

    return numOrders;
  }

  Future<List<OrderModel>> getOrder() async {
    Database db = await instance.database;

    var order = await db.query('orders');

    List<OrderModel> orderList = order.isNotEmpty
        ? order.map((e) => OrderModel.fromMap(e)).toList()
        : [];
    return orderList;
  }

  Future<void> updateOrder(OrderModel order) async {
    final db = await database;

    await db.update(
      'orders',
      order.toMap(),
      where: 'ordernumber = ?',
      whereArgs: [
        ['ordernumber'],
      ],
    );
  }

  Future<void> deleteOrder(String orderNumber) async {
    final db = await database;

    await db.delete('orders', where: 'ordernumber = ?', whereArgs: [
      [orderNumber]
    ]);
  }

//---------CROCHET THREAD DB FUNCTIONS---------//
  Future<void> addCrochetThread(CrochetThreadModel crochetThread) async {
    Database db = await instance.database;

    await db.insert('crochetthread', crochetThread.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<CrochetThreadModel>> getCrochetThread() async {
    Database db = await instance.database;

    var crochetThread = await db.query('crochetthread');

    List<CrochetThreadModel> crochetThreadList = crochetThread.isNotEmpty
        ? crochetThread.map((e) => CrochetThreadModel.fromMap(e)).toList()
        : [];

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

//---------YARN DB FUNCTIONS---------//
  Future<void> addYarn(YarnModel yarn) async {
    Database db = await instance.database;

    await db.insert('yarn', yarn.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<YarnModel>> getYarn() async {
    Database db = await instance.database;

    var yarn = await db.query('yarn');

    List<YarnModel> yarnList =
        yarn.isNotEmpty ? yarn.map((e) => YarnModel.fromMap(e)).toList() : [];
    return yarnList;
  }

  Future<void> deleteYarn(int yarnNumber) async {
    final db = await database;

    await db.delete(
      'yarn',
      where: 'yarnnumber = ?',
      whereArgs: [
        'yarnnumber'
      ], // Pass the id as a whereArg to prevent SQL injection.
    );
    //notifyListeners();
  }
}
