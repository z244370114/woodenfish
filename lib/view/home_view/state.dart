import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woodenfish/view/me_view/view.dart';

import '../../generated/l10n.dart';
import '../../utils/google_in_app_purchase.dart';
import '../../widgets/keep_alive_page.dart';
import '../main_view/view.dart';
import '../prayer_beads_view/view.dart';
import '../skin_view/view.dart';

class HomeViewState {
  ///选择index
  late int selectedIndex = 0;

  ///分类按钮数据源
  late List<NavigationDestination> list;

  ///PageView页面
  late List<Widget> pageList;

  HomeViewState() {
    pageList = [
      KeepAlivePage(MainViewPage()),
      KeepAlivePage(PrayerBeadsViewPage()),
      KeepAlivePage(SkinViewPage()),
      KeepAlivePage(MeViewPage()),
    ];
    list = [
      NavigationDestination(
        icon: Icon(Icons.home),
        label: S.of(Get.context!).home,
      ),
      NavigationDestination(
        icon: Image(
          image: AssetImage("assets/images/fz-s.png"),
          width: 24.0,
        ),
        label: S.of(Get.context!).prayerBeads,
      ),
      NavigationDestination(
        icon: Icon(Icons.heart_broken_rounded),
        label: S.of(Get.context!).skin,
      ),
      NavigationDestination(
        icon: Icon(Icons.padding),
        label: S.of(Get.context!).me,
      ),
    ];
  }
}
