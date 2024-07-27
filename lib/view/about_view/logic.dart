import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../plugin/method_plugin.dart';
import 'state.dart';

class AboutViewLogic extends GetxController {
  final AboutViewState state = AboutViewState();

  @override
  Future<void> onInit() async {
    super.onInit();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
      state.versionName.value = packageInfo.version;
      update();
  }
}
