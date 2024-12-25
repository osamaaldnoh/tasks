import 'package:get/state_manager.dart';

import '../core/app_db1.dart';
import '../model/currency.dart';

class Currencies extends GetxController {
  RxList<Currency> _currencies = RxList<Currency>([]);
  RxList<Currency> get currencies => RxList([..._currencies]);
  AppDB _appDB = AppDB();
  int? length;
  String tableName = 'currencies';

  @override
  void onInit() {
    getCurrenciesData();
    super.onInit();
  }

  addNewCurrency({Currency? currency}) async {
    length = _currencies.isEmpty ? 0 : _currencies.last.currencyId;

    await _appDB.insertTable(tableName, currency!.toMap());
    getCurrenciesData();
  }

  Future<void> getCurrenciesData() async {
    //AppDB.nameTable = 'currencies';
    List<Map<String, dynamic>> getcurrencies =
        await AppDB.getTableData(tableName);
    if (getcurrencies.isEmpty) {
      await _appDB.insertTable(tableName, {
        'currencyName': 'osama',
        'currencySymbol': 'O',
      });
      await _appDB.insertTable(tableName, {
        'currencyName': 'ahmed',
        'currencySymbol': 'A',
      });
      await _appDB.insertTable(tableName, {
        'currencyName': 'mohmmed',
        'currencySymbol': 'M',
      });
      getCurrenciesData();
    }
    _currencies
        .assignAll(getcurrencies.map((e) => new Currency.map(e)).toList());

    _currencies.forEach((element) {
      print('Name: ${element.currencyName}');
    });
    // _appDB.getTasksData(tableName).then((value) {
    //   value.forEach((element) {
    //     _currencies.assignAll(Currency(
    //         currencyId: element['currencyId'],
    //         currencyName: element['currencyName']));
    //   });
    // });
  }

  Currency findById(String currencyName) {
    return currencies
        .firstWhere((element) => element.currencyName == currencyName);
  }

  editCurrency({
    Currency? currency,
  }) async {
    await _appDB.updateDate(tableName, currency!.toMap(), 'currencyId');
    getCurrenciesData();
  }

  deleteCurrency({Currency? currency}) async {
    _currencies.length == 1
        ? ''
        : await _appDB.deleteRow(tableName, currency!.toMap(), 'currencyId');
    getCurrenciesData();
  }

  RxString _orderType = ''.obs;
  RxString get orderType => _orderType;

  void setOrderType(String type) {
    _orderType.value = type;
    print('Type :$_orderType');
    // update();
  }
}
