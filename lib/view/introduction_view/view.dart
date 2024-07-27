import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import 'logic.dart';

class IntroductionViewPage extends StatelessWidget {
  IntroductionViewPage({Key? key}) : super(key: key);

  final logic = Get.put(IntroductionViewLogic());
  final state = Get.find<IntroductionViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).wfIntroduction),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ic_launcher_round.png',
              width: 60,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                S.of(context).introductionInfo,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
