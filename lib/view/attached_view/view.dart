import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'logic.dart';

class AttachedViewPage extends StatelessWidget {
  AttachedViewPage({Key? key}) : super(key: key);

  final logic = Get.put(AttachedViewLogic());
  final state = Get.find<AttachedViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("祈福图"),
      ),
      body: MasonryGridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          return Text("data");
        },
      ),
    );
  }
}
