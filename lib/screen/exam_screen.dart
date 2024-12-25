import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/controller/currencies.dart';
import 'package:tasks/core/app_db1.dart';
import 'package:path/path.dart';
import 'package:tasks/model/currency.dart';
import 'package:tasks/screen/main_tasks_screen.dart';

class ExamScreen extends StatelessWidget {
  ExamScreen({Key? key}) : super(key: key);
  //Currencies currencies = Get.find<Currencies>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Obx(
              () => PageView.builder(
                  itemCount: Get.find<Currencies>().currencies.length,
                  itemBuilder: (context, index) {
                    return MainTasksScreen();
                  }),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.1,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.01,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  elevation: 0,
                  onPressed: () async {
                    // String dataBasepath = await getDatabasesPath();
                    // String path = join(dataBasepath, 'accounts_book.db');
                    // AppDB.deleteDatabase(path);
                    await Get.find<Currencies>().deleteCurrency(
                      currency: Get.find<Currencies>().findById('Osama'),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1 / 2,
                      ),
                      Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Obx(
// () => currencies.currencies.isNotEmpty
// ? ListView.builder(
// shrinkWrap: true,
// itemCount: currencies.currencies.length,
// itemBuilder: (context, index) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// '${currencies.currencies[index].currencyName}'),
// Text(
// '${currencies.currencies[index].currencySymbol}'),
// Text('${currencies.currencies[index].currencyId}'),
// ],
// ),
// );
// })
// : Container(),
// ),
