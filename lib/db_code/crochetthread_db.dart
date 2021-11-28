import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ttc_workshop_2/models/crochetthread_model.dart';

class CrochetThreadDatabaseHelper {
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
      threadNumber TEXT PRIMARY KEY
      threadColor TEXT,
      image BLOB,
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
  }

  Future<List<CrochetThreadModel>> getCrochetThread() async {
    Database db = await instance.database;

    var crochetThread = await db.query('crochetthread');

    List<CrochetThreadModel> crochetThreadList = crochetThread.isNotEmpty
        ? crochetThread.map((e) => CrochetThreadModel.fromMap(e)).toList()
        : [];
    return crochetThreadList;

    //final List<Map<String, dynamic>> maps = await db.query('crochetthread');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    // return List.generate(maps.length, (i) {
    //   return CrochetThreadModel(
    //     threadNumber: maps[i]['threadnumber'],
    //     threadColor: maps[i]['threadcolor'],
    //     image: maps[i]['image'],
    //     brand: maps[i]['brand'],
    //     material: maps[i]['material'],
    //     size: maps[i]['size'],
    //     availableWeight: maps[i]['availableweight'],
    //     pricePerGram: maps[i]['pricepergram'],
    //     weight: maps[i]['weight'],
    //     reccHookNeedle: maps[i]['recchookneedle'],
    //     cost: maps[i]['cost'],
    //   );
    // });
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
