import 'package:get/get.dart';

import '../main_view/logic.dart';
import '../prayer_beads_view/logic.dart';
import 'state.dart';

class HomeViewLogic extends GetxController {
  final HomeViewState state = HomeViewState();

  @override
  void onInit() {
    super.onInit();
    // AdState.nativeAd();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onChangeIndex(index) {
    state.selectedIndex = index;
    switch (index) {
      case 0:
        Get.find<MainViewLogic>().updatesData();
        break;
      case 1:
        Get.find<PrayerBeadsViewLogic>().updatesData();
        break;
    }
    update();
  }
}
