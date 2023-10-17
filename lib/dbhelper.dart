import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databasehelper {
  static const _databasename = "persons.db";
  static const _databaseversion = 1;

  static const table = "my_table";

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnage = 'age';

  Database? _database;

// This function is used to check whether database is present or not if it is present it will
// return previous database else new database will be initiated ..
  Future<Database?> get databse async {
    // ignore: unnecessary_null_comparison
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _oncreate);
  }

  Future _oncreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnage INTEGER NOT NULL
      )
      ''',
    );
  }

// This is used to create instance of above database.while performing operation we can
// just simpley use its instance and perform different query
  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  // function to insert
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.databse;
    return await db!.insert(table, row);
    // Now we have to call this function from homepage  to insert data into database
  }

  //query rows (Displaying all data that are present in database)
  // It return data in form of list

  Future<List<Map<String, dynamic>>> queryall() async {
    Database? db = await instance.databse;
    return await db!.query(table);
  }

  // To retrieve specific data  we do querySpecific
  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database? db = await instance.databse;
    var res = await db!.query(table, where: "age > ?", whereArgs: [age]);
    // WE CAN ALSO USE rawQuery.'?' IS USED AS PARAMETER WHICH CAME AS ARGUMENT AND WE CAN PASS
    // MULTIPLE ARGUMENT LIKE [age,id]
    // var res=await db!.rawQuery('SELECT * FROM my_table WHERE age>?',[age]);
    return res;
  }

  // To delete specific data
  Future<int> deleteData(int id) async {
    Database? db = await instance.databse;
    var res = await db!.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  // To update specific data  we do querySpecific
  Future<int> updateData(int id) async {
    Database? db = await instance.databse;
    var res = await db!.update(table, {"name": "Saka", "age": 23},
        where: "id = ?", whereArgs: [id]);
    return res;
  }
}
