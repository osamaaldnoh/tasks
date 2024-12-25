import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tasks/model/tasks_model.dart';

class AppDatabase {
  static Database? _database;
  static String nameTable = 'taskLists.db';
  static Future<void> initDB() async {
    //String dbFolder = await getDatabasesPath();
    //String dbFinalPath = join(dbFolder, 'taskLists.db');
    if (_database != null) {
      print('Database Not Null');
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'taskLists.db';
      print('In path Database');
      _database =
          await openDatabase(_path, version: 1, onCreate: (db, version) async {
        print('In OnCreate');
        return db.execute(
            "CREATE TABLE taskList(id integer primary key autoincrement,title Text,endDate STRING)");
      });
      print('Data Base Create');
    } catch (e) {
      print(e);
    }
  }

//endTime varchar not null
  static Future<int> insertTable(TasksModel? tasksModel) async {
    print('OOOOOOOOOOOoooooooooooooooooooooooooooooooooooooooooooo');
    try {
      return await _database!.insert('taskList', tasksModel!.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
      return 90000;
    }
  }

  static Future<List<Map<String, dynamic>>> getTasksData() async {
    final db = await initDB();
    return await _database!.query('taskList');
  }

  static Future<int> updateDate(TasksModel tasksModel) async {
    final dbUpdate = await initDB();
    return await _database!.update('taskList', tasksModel.toMap(),
        where: 'id = ?',
        whereArgs: [tasksModel.tId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTasks(TasksModel tasksModel) async {

    return await _database!.delete(
      'taskList',
      where: 'id = ?',
      whereArgs: [tasksModel.tId],
    );
  }

  Future<List<Map<String, dynamic>>?> getAllTasks() async {
    final db = await initDB();

    final List<Map<String, dynamic>> maps = await _database!.query('taskList');

    if (maps.isEmpty) {
      return null;
    }
    return maps;
  }
}
