import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task.dart';

class DataBaseService {
  static final DataBaseService instance = DataBaseService._constructor();

  static Database? _db;
  final String _tasksTableName = 'tasks';
  final String _tasksIdColumnName = 'id';
  final String _tasksContentColumnName = 'content';
  final String _tasksStatusColumnName = 'status';

  DataBaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDataBase();
    return _db!;
  }

  Future<Database> getDataBase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'master_db.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
                    CREATE TABLE $_tasksTableName(
                    $_tasksIdColumnName INTEGER PRIMARY KEY,
                    $_tasksContentColumnName TEXT NOT NULL,
                    $_tasksStatusColumnName INTEGER NOT NULL
                    
                    )
          
          ''');
      },
    );
    return database;
  }

  void addTask(String content) async {
    final db = await database;
    await db.insert(_tasksTableName, {
      _tasksContentColumnName: content,
      _tasksStatusColumnName: 0,
    });
  }

  Future<List<Task>> getTask() async {
    final db = await database;
    final data = await db.query(_tasksTableName);
    List<Task> tasks = data
        .map((e) => Task(
            content: e['content'] as String,
            status: e['status'] as int,
            id: e['id'] as int))
        .toList();
    return tasks;
  }

  void updateTaskStatus(int id, int status) async {
    final db = await database;

    await db.update(_tasksTableName, {
      _tasksStatusColumnName: status,

    },
      where: 'id=?',
      whereArgs: [id],

    );
  }

  void deleteTask(int id)async{

    final db = await database;
    await db.delete(_tasksTableName,where: 'id=?',whereArgs: [id]);
  }




}
