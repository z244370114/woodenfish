import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/constant.dart';
import '../common/route_config.dart';
import '../generated/l10n.dart';

class DrawerLayout extends StatefulWidget {
  const DrawerLayout({Key? key}) : super(key: key);

  @override
  State<DrawerLayout> createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: const Color(0xff262628),
      width: 200,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/gz.png',
                width: 60,
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  S.of(context).hello,
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              )
            ],
          ),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white70),
              ),
              margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/images/if.png',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextButton.icon(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white70)),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(200, 50))),
              icon: const Icon(
                Icons.settings,
                color: Colors.white70, //for icon color
              ),
              label: Text(
                S.of(context).setting,
                style: TextStyle(
                  color: Colors.white70, //for text color
                ),
              ),
              onPressed: () {
                Get.toNamed(RouteConfig.setting);
              },
            ),
          ),
          Container(
            child: TextButton.icon(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white70)),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(200, 50))),
              icon: const Icon(
                Icons.account_box_outlined,
                color: Colors.white70, //for icon color
              ),
              label: Text(
                S.of(context).privacyPolicy,
                style: TextStyle(
                  color: Colors.white70, //for text color
                ),
              ),
              onPressed: () {
                Constant.isClickAgreement = false;
                Get.toNamed(
                    '${RouteConfig.webPage}?title=${S.of(context).privacyPolicy}&url=${Constant.privacyUrl}');
              },
            ),
          ),
          Container(
            child: TextButton.icon(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white70)),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(200, 50))),
              icon: const Icon(
                Icons.deck_rounded,
                color: Colors.white70, //for icon color
              ),
              label: Text(
                S.of(context).aboutUs,
                style: TextStyle(
                  color: Colors.white70, //for text color
                ),
              ),
              onPressed: () {
                Get.toNamed(RouteConfig.about);
              },
            ),
          )
        ],
      ),
    ));
  }
}
