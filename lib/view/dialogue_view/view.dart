import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class DialogueViewPage extends StatelessWidget {
  DialogueViewPage({Key? key}) : super(key: key);

  final logic = Get.put(DialogueViewLogic());
  final state = Get.find<DialogueViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
