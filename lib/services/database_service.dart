import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'health_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            heartRate INTEGER,
            steps INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertRecord(String date, int heartRate, int steps) async {
    final db = await database;
    await db.insert('history', {
      'date': date,
      'heartRate': heartRate,
      'steps': steps,
    });
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return await db.query('history', orderBy: 'id DESC');
  }

  Future<void> deleteOldRecords(String date) async {
    final db = await database;
    await db.delete('history', where: 'date < ?', whereArgs: [date]);
  }

  Future<void> deleteExcessRecords(int count) async {
    final db = await database;
    await db.delete('history', where: 'id IN (SELECT id FROM history ORDER BY id ASC LIMIT ?)', whereArgs: [count]);
  }
}