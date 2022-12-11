import 'package:something/models/barang.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  static late Database _database;

  Future<Database> get database async {
    return _database = await _initializeDb();
  }

  static const String _tableName = 'barang';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '${path}app.db',
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, name TEXT, description TEXT, price TEXT, quantity INTEGER)''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> tambahBarang(Barang barang) async {
    final Database db = await database;
    await db.insert(
      _tableName,
      barang.toMap(),
    );
  }

  Future<List<Barang>> listBarang() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);

    return result.map((res) => Barang.fromMap(res)).toList();
  }

  Future<void> hapusBarang(int id) async {
    final Database db = await database;

    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateBarang(Barang barang) async {
    final Database db = await database;

    await db.update(
      _tableName,
      barang.toMap(),
      where: 'id = ?',
      whereArgs: [barang.id],
    );
  }
}
