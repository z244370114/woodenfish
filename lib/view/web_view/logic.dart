import 'package:get/get.dart';

import 'state.dart';

class WebViewLogic extends GetxController {
  final WebViewState state = WebViewState();

  @override
  void onInit() {
    super.onInit();
    state.title = Get.parameters['title'].toString();
    state.url = Get.parameters['url'].toString();
  }
}
