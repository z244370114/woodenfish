import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomeViewPage extends StatelessWidget {
  HomeViewPage({Key? key}) : super(key: key);

  final logic = Get.put(HomeViewLogic());
  final state = Get.find<HomeViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewLogic>(builder: (logic) {
      return Scaffold(
        body: IndexedStack(
          index: state.selectedIndex,
          children: state.pageList,
        ),
        bottomNavigationBar: buildBottom(),
      );
    });
  }

  buildBottom() {
    return NavigationBar(
      elevation: 1,
      backgroundColor: Colors.transparent,
      destinations: state.list,
      selectedIndex: state.selectedIndex,
      onDestinationSelected: (selectedIndex) {
        logic.onChangeIndex(selectedIndex);
      },
    );
  }
}
