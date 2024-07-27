import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../../plugin/method_plugin.dart';
import 'logic.dart';

class AboutViewPage extends StatelessWidget {
  AboutViewPage({Key? key}) : super(key: key);

  final logic = Get.put(AboutViewLogic());
  final state = Get.find<AboutViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).aboutUs),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ic_launcher_round.png',
              width: 60,
            ),
            Text(
              S.of(context).appName,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Obx(() {
              return Text(
                "${S.of(context).version}${state.versionName.value}",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              );
            }),
            Text(
              "联系我们：zyuan9871@gmail.com",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                S.of(context).aboutInfo,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
