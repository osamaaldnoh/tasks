import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tasks/controller/currencies.dart';
import 'package:tasks/core/app_db1.dart';
import 'package:tasks/screen/exam_screen.dart';
import 'package:tasks/screen/main_tasks_screen.dart';
import 'package:tasks/widgets/card_tasks_widget.dart';
import 'package:tasks/widgets/show_bottom_sheet.dart';
import 'package:path/path.dart';
import 'core/app_db.dart';
import 'core/my_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // String dataBasepath = await getDatabasesPath();
  // String path = join(dataBasepath, 'accounts_book.db');
  // await AppDB.deleteDatabase(path);
  //
  await AppDB.db;
  //await AppDB.insertDataforOpenApp();
  //await AppDB.getCurrenciesData();
  // await AppDatabase.initDB();
  //Get.put(Currencies());
  MyBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialBinding: MyBindings(),
      home: ExamScreen(),
      routes: {
        ShowBottomSheet.routeName: (_) => ShowBottomSheet(),
      },
    );
  }
}
