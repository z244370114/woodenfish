import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woodenfish/utils/toast_util.dart';

import '../../common/application.dart';
import '../../common/constant.dart';
import '../../generated/l10n.dart';
import '../../plugin/method_plugin.dart';
import '../../utils/event_bus.dart';
import '../../utils/platform_utils.dart';
import 'state.dart';

class SkinViewLogic extends GetxController with SingleGetTickerProviderMixin {
  final SkinViewState state = SkinViewState();

  @override
  void onInit() {
    super.onInit();
    state.tabController = TabController(length: 3, vsync: this);
    state.skinIndex = Application.getStorage.read(Constant.skinKey) ?? 0;
    state.prayerBeadsSkinIndex =
        Application.getStorage.read(Constant.prayerBeadsKey) ?? 0;
  }

  @override
  void onReady() {
    super.onReady();
    // BannerAd(
    //   adUnitId: "ca-app-pub-6237326926737313/5069805027",
    //   request: const AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) {
    //       state.bannerAd = ad as BannerAd;
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       ad.dispose();
    //     },
    //   ),
    // ).load();

    EventBus.getDefault().register(null, (event) {
      if (event is String) {
        return;
      }
      var key = (event as Map)['isSkinLockKey'];
      var status = (event)['status'];
      switch (key) {
        case Constant.isSkinLockKey:
          if (status) {
            state.dataList[state.skinSelectIndex]['isLock'] = false;
            state.isSkinLockState[state.skinSelectIndex] = false;
            state.skinIndex = state.skinSelectIndex;
            Application.getStorage.write(Constant.skinKey, state.skinIndex);
            EventBus.getDefault().post(Constant.skinKey);
            Application.getStorage
                .write(Constant.isSkinLockKey, state.isSkinLockState);
            update();
          } else {
            state.skinSelectIndex = state.skinIndex;
          }
          break;
        default:
          break;
      }
    });
    if (PlatformUtils.isAndroid) {
      MethodPlugin.isGoogleChannel().then((value) {
        state.isRestore = value;
        update();
      });
      state.appPurchase.loadProducts();
      initSkinLockList();
      // MethodPlugin.isGoogleChannel().then((value) {
      //   if (!value) {
      //     state.isSkinLockState = [
      //       false,
      //       false,
      //       false,
      //       false,
      //       false,
      //       false,
      //       false,
      //       false,
      //     ];
      //     var siknNames = S
      //         .of(Get.context!)
      //         .siknNames
      //         .split(',')
      //         .map((e) => e.trim())
      //         .toList();
      //     for (int i = 0; i < state.dataList.length; i++) {
      //       var item = state.dataList[i];
      //       item['title'] = siknNames[i];
      //       item['isLock'] = false;
      //     }
      //     update();
      //   } else {
      //     state.appPurchase.loadProducts();
      //     initSkinLockList();
      //   }
      // });
    } else {
      initSkinLockList();
      state.appPurchase.loadProducts();
    }
  }

  @override
  void onClose() {
    super.onClose();
    // state.bannerAd?.dispose();
    state.tabController.dispose();
    state.appPurchase.dispose();
  }

  void initSkinLockList() {
    if (Application.getStorage.hasData(Constant.isSkinLockKey)) {
      state.isSkinLockState =
          Application.getStorage.read(Constant.isSkinLockKey).cast<bool>();
      var siknNames =
          S.of(Get.context!).siknNames.split(',').map((e) => e.trim()).toList();
      for (int i = 0; i < state.dataList.length; i++) {
        var item = state.dataList[i];
        item['title'] = siknNames[i];
        item['isLock'] = state.isSkinLockState[i];
      }
      update();
    } else {
      Application.getStorage
          .write(Constant.isSkinLockKey, state.isSkinLockState);
    }
  }

  purchase(index) {
    if (state.dataList[index]['isLock'] != null &&
        state.dataList[index]['isLock'] == false) {
      state.skinSelectIndex = index;
      state.skinIndex = index;
      Application.getStorage.write(Constant.skinKey, index);
      EventBus.getDefault().post(Constant.skinKey);
      // Get.find<HomeViewLogic>().onChangeIndex(0);
      update();
    } else {
      if (index != 0) {
        ToastUtil.showProgress(Get.context!);
        state.skinSelectIndex = index;
        state.appPurchase
            .startPurchase(state.appPurchase.products?[index - 1].id ?? "");
      }
    }
  }

  fu(index) {
    state.fuIndex = index;
    Application.getStorage.write(Constant.fuKey, index);
    EventBus.getDefault().post(Constant.fuKey);
    update();
  }

  void prayerBeadsPurchase(index) {
    if (state.prayerBeadsList[index]['isLock'] != null &&
        state.prayerBeadsList[index]['isLock'] == false) {
      state.prayerBeadsSkinIndex = index;
      state.prayerBeadsSkinSelectIndex = index;
      Application.getStorage.write(Constant.prayerBeadsKey, index);
      EventBus.getDefault().post(Constant.prayerBeadsKey);
      update();
    } else {
      if (index != 0) {
        ToastUtil.showProgress(Get.context!);
        state.prayerBeadsSkinSelectIndex = index;
        state.appPurchase
            .startPurchase(state.appPurchase.products?[index - 1].id ?? "");
      }
    }
  }
}
