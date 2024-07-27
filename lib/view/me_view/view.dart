import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:woodenfish/plugin/method_plugin.dart';

import '../../common/constant.dart';
import '../../common/route_config.dart';
import '../../generated/l10n.dart';
import 'logic.dart';

class MeViewPage extends StatelessWidget {
  MeViewPage({Key? key}) : super(key: key);

  final logic = Get.put(MeViewLogic());
  final state = Get.find<MeViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).me),
      ),
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/h7.png',
                    width: 120.w,
                    height: 120.w,
                  ),
                  SizedBox(width: 30.w),
                  Text(
                    S.of(context).hello,
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  )
                ],
              ),
              SizedBox(height: 30.w),
              Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), // 指定圆角大小
                  child: Image.asset(
                    'assets/images/if.png',
                    height: 300.w,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ), // 图片路径或网络地址
                ),
              ),
              SizedBox(height: 30.w),
              // TextButton.icon(
              //   style: ButtonStyle(
              //       textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white70)),
              //       alignment: Alignment.centerLeft,
              //       minimumSize: MaterialStateProperty.all(const Size(200, 50))),
              //   icon: const Icon(
              //     Icons.card_membership,
              //     color: Colors.white70, //for icon color
              //   ),
              //   label: Text(
              //     S.of(context).setting,
              //     style: const TextStyle(
              //       color: Colors.white70, //for text color
              //     ),
              //   ),
              //   onPressed: () {
              //     Get.toNamed(RouteConfig.vip);
              //   },
              // ),
              TextButton.icon(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white70)),
                    alignment: Alignment.centerLeft,
                    minimumSize: MaterialStateProperty.all(const Size(200, 50))),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white70, //for icon color
                ),
                label: Text(
                  S.of(context).setting,
                  style: const TextStyle(
                    color: Colors.white70, //for text color
                  ),
                ),
                onPressed: () {
                  Get.toNamed(RouteConfig.setting);
                },
              ),
              TextButton.icon(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white70)),
                    alignment: Alignment.centerLeft,
                    minimumSize: MaterialStateProperty.all(const Size(200, 50))),
                icon: const Icon(
                  Icons.account_box_outlined,
                  color: Colors.white70, //for icon color
                ),
                label: Text(
                  S.of(context).privacyPolicy,
                  style: const TextStyle(
                    color: Colors.white70, //for text color
                  ),
                ),
                onPressed: () {
                  Constant.isClickAgreement = false;
                  Get.toNamed('${RouteConfig.webPage}?title=${S.of(context).privacyPolicy}&url=${Constant.privacyUrl}');
                },
              ),
              TextButton.icon(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white70)),
                    alignment: Alignment.centerLeft,
                    minimumSize: MaterialStateProperty.all(const Size(200, 50))),
                icon: const Icon(
                  Icons.privacy_tip,
                  color: Colors.white70, //for icon color
                ),
                label: Text(
                  S.of(context).termsUse,
                  style: const TextStyle(
                    color: Colors.white70, //for text color
                  ),
                ),
                onPressed: () {
                  Constant.isClickAgreement = false;
                  Get.toNamed('${RouteConfig.webPage}?title=${S.of(context).termsUse}&url=${Constant.termsUseUrl}');
                },
              ),
              TextButton.icon(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white70)),
                    alignment: Alignment.centerLeft,
                    minimumSize: MaterialStateProperty.all(const Size(200, 50))),
                icon: const Icon(
                  Icons.score,
                  color: Colors.white70,
                ),
                label: Text(
                  S.of(context).givePraise,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                onPressed: () {
                  MethodPlugin.sikpPlay();
                },
              ),
              TextButton.icon(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white70)),
                    alignment: Alignment.centerLeft,
                    minimumSize: MaterialStateProperty.all(const Size(200, 50))),
                icon: const Icon(
                  Icons.deck_rounded,
                  color: Colors.white70, //for icon color
                ),
                label: Text(
                  S.of(context).aboutUs,
                  style: const TextStyle(
                    color: Colors.white70, //for text color
                  ),
                ),
                onPressed: () {
                  Get.toNamed(RouteConfig.about);
                },
              ),
              TextButton.icon(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white70)),
                    alignment: Alignment.centerLeft,
                    minimumSize: MaterialStateProperty.all(const Size(200, 50))),
                icon: const Icon(
                  Icons.integration_instructions,
                  color: Colors.white70, //for icon color
                ),
                label: Text(
                  S.of(context).wfIntroduction,
                  style: const TextStyle(
                    color: Colors.white70, //for text color
                  ),
                ),
                onPressed: () {
                  // logic.getData();
                  Get.toNamed(RouteConfig.introduction);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
