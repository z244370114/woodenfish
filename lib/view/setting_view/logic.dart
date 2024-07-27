import 'package:get/get.dart';
import 'package:woodenfish/utils/pub_method.dart';
import 'package:woodenfish/utils/toast_util.dart';

import '../../common/application.dart';
import '../../common/constant.dart';
import '../../generated/l10n.dart';
import '../../utils/event_bus.dart';
import 'state.dart';

class SettingViewLogic extends GetxController {
  final SettingViewState state = SettingViewState();

  @override
  void onInit() {
    super.onInit();
    PubMethodUtils.parseSensitiveWords().then((value) {
      state.trie = value;
    });
    // PubMethodUtils.parseSensitiveWords1().then((value) {
    //   state.ac = value;
    // });
  }

  getData() async {
    var suspendedKey = Application.getStorage.read(Constant.suspendedKey) ?? "";
    if (suspendedKey.isNotEmpty) {
      state.suspendedText = suspendedKey;
    }
    bool s = Application.getStorage.read(Constant.musicKey) ?? false;
    bool snowflake =
        Application.getStorage.read(Constant.snowflakeKey) ?? false;
    bool autoKnock =
        Application.getStorage.read(Constant.autoKnockKey) ?? false;
    var intervalTime =
        Application.getStorage.read(Constant.intervalTimeKey) ?? 1.0;
    state.switchMusicValue = s;
    state.switchAutoValue = autoKnock;
    state.snowflakeValue = snowflake;
    if (intervalTime >= 1) {
      state.sliderValue = intervalTime;
    }
    // var skin = Application.getStorage.read(Constant.skinKey) ?? "";
    // if (skin.isNotEmpty) {
    //   state.skinIndex = Constant.dataList.indexOf(skin);
    // }
    var toneColour = Application.getStorage.read(Constant.toneColourKey) ?? "";
    if (toneColour.isNotEmpty) {
      state.toneColourIndex = Constant.toneColour.indexOf(toneColour);
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  String getToneColour(item) {
    var index = Constant.toneColour.indexOf(item) + 1;
    return index >= 10 ? "$index" : "0$index";
  }

  setSuspended() {
    if (PubMethodUtils.parseSearch(
        state.textEditingController.text, state.trie)) {
      ToastUtil.showToast(S.of(Get.context!).suspendedNoTip);
    } else {
      Get.back();
      Application.getStorage
          .write(Constant.suspendedKey, state.textEditingController.text);
      state.suspendedText = state.textEditingController.text;
      EventBus.getDefault().post(Constant.suspendedKey);
    }
  }
}
