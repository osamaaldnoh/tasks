import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDB {
  static Database? _db;
  static String accGroups = 'accGroups';
  static String currencies = 'currencies';
  static String accRestrichions = 'accRestrichions';
  static String customers = 'customers';

  static Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  static intialDb() async {
    String dataBasepath = await getDatabasesPath();
    String path = join(dataBasepath, 'accounts_book.db');
    Database mydb = await openDatabase(path, onCreate: _ocCreate, version: 1);
    return mydb;
  }

  static Future<void> _ocCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE $currencies(
   currencyId integer primary key autoincrement,
   currencyName Text,
   currencySymbol STRING
   )
   ''');

    print('Create DataBase And Table .......................');
  }

  insertTable(String tableName, Map<String, Object?> toMap) async {
    Database? mydb = await db;
    try {
      return await mydb!.insert(
        tableName!,
        toMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
      return 90000;
    }
  }

  static Future<List<Map<String, dynamic>>> getTableData(
      String tableName) async {
    Database? mydb = await db;
    return await mydb!.query(tableName);
  }

  Future<int> updateDate(
      String tableName, Map<String, Object?> toMap, String nameId) async {
    Database? mydb = await db;
    return await mydb!.update(tableName!, toMap,
        where: '$nameId =?',
        whereArgs: [toMap['$nameId']],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteRow(String tableName, Map<String, Object?> toMap, String nameId) async {
    Database? mydb = await db;
    return await mydb!
        .delete(tableName, where: '$nameId = ?', whereArgs: [toMap['$nameId']]);
  }

  // deleteOptionTable() async {
  //   Database? mydb = await db;
  //   mydb!.rawDelete("Delete * from $nameTable");
  // }
  //
  static Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  static insertDataforOpenApp() async {
    Database? myDb = await db;
    try {
      return await myDb!.insert(
        accGroups,
        toMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
      return 90000;
    }
  }

  static Map<String, dynamic> toMap = {
    'accGroupName': 'osama',
    'created_at': '20-12',
  };
  static List<String> list = [];
  static Future<void> getCurrenciesData() async {
    //AppDB.nameTable = 'currencies';
    List<Map<String, dynamic>> getcurrencies = await getTableData(accGroups);
    getcurrencies.forEach((element) {
      list.add(element['accGroupName']);
      print('accGroups : ${element['accGroupName']}');
    });

    // _appDB.getTasksData(tableName).then((value) {
    //   value.forEach((element) {
    //     _currencies.assignAll(Currency(
    //         currencyId: element['currencyId'],
    //         currencyName: element['currencyName']));
    //   });
    // });
  }
}
