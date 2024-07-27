import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/web_page.dart';
import 'logic.dart';

class WebViewPage extends StatelessWidget {
  WebViewPage({Key? key}) : super(key: key);

  final logic = Get.put(WebViewLogic());
  final state = Get.find<WebViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return WebPage(title: state.title, url: state.url);
  }
}
