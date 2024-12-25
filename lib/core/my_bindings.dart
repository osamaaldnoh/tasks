import 'package:get/get.dart';

import '../controller/currencies.dart';

class MyBindings implements Bindings {
  // static Future<void> init() async {
  //   Get.lazyPut<AccGroups>(() => AccGroups(), fenix: true);
  //   Get.lazyPut<Currencies>(() => Currencies(), fenix: true);
  //   Get.lazyPut<AccRestrichions>(() => AccRestrichions(), fenix: true);
  //   Get.lazyPut<Customers>(() => Customers(), fenix: true);
  // }
  @override
  void dependencies() {
    //Get.lazyPut<AccGroups>(() => AccGroups(), fenix: true);
    Get.lazyPut<Currencies>(() => Currencies(), fenix: true);
    // Get.lazyPut<AccRestrichions>(() => AccRestrichions(), fenix: true);
    // Get.lazyPut<Customers>(() => Customers(), fenix: true);
  }
}
