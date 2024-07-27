import 'dart:async';

import 'package:alipay_kit/alipay_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:woodenfish/utils/toast_util.dart';

import '../common/constant.dart';
import '../generated/l10n.dart';
import '../network/http_api.dart';
import '../network/http_utils.dart';
import 'event_bus.dart';
import 'log_util.dart';
import 'platform_utils.dart';

class GoogleInAppPurchase {
  late StreamSubscription<List<PurchaseDetails>> subscription;
  late InAppPurchase inAppPurchase = InAppPurchase.instance;
  List<ProductDetails>? products; //内购的商品对象集合
  late final StreamSubscription<AlipayResp> _paySubs;
  var orderId = "";

  GoogleInAppPurchase() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (Object error) {
      error.printError();
      ToastUtil.showToast("购买失败");
    });
  }

  /// 加载全部的商品
  void loadProducts() async {
    final bool available = await inAppPurchase.isAvailable();
    if (!available) {
      _paySubs = AlipayKitPlatform.instance.payResp().listen(listenPay);
      // ToastUtil.showToast("无法连接到商店");
      return;
    }
    //开始购买
    const Set<String> _kIds = <String>{
      'xhx_woodenfish_skin1',
      'xhx_woodenfish_skin2',
      'xhx_woodenfish_skin3',
      'xhx_woodenfish_skin4',
      'xhx_woodenfish_skin5',
      'xhx_woodenfish_skin6',
      'xhx_woodenfish_skin7',
      'com.xhx.woodenfish.monthly',
      'com.xhx.woodenfish.quarterly',
      'com.xhx.woodenfish.yearly'
    };
    final ProductDetailsResponse response =
        await inAppPurchase.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      ToastUtil.showToast("无法找到指定的商品");
      return;
    }

    // 处理查询到的商品列表
    List<ProductDetails> products = response.productDetails;
    if (products.isNotEmpty) {
      //赋值内购商品集合
      this.products = products;
    }

    //先恢复可重复购买
    await inAppPurchase.restorePurchases();
  }

  void restore() {
    inAppPurchase.restorePurchases();
  }

  // 调用此函数以启动购买过程
  void startPurchase(String productId) async {
    final bool available = await inAppPurchase.isAvailable();
    if (available && products != null && products!.isNotEmpty) {
      ToastUtil.showToast(S.of(Get.context!).startShop);
      try {
        ProductDetails productDetails = _getProduct(productId);
        // Log.d(
        //     "一切正常，开始购买,信息如下：title: ${productDetails.title}  desc:${productDetails.description} "
        //     "price:${productDetails.price}  currencyCode:${productDetails.currencyCode}  currencySymbol:${productDetails.currencySymbol}");
        inAppPurchase.buyConsumable(
            purchaseParam: PurchaseParam(productDetails: productDetails));
      } catch (e) {
        e.printError();
        Log.e("购买失败了");
        ToastUtil.closeProgress(Get.context!);
      }
    } else {
      ToastUtil.showToast(S.of(Get.context!).startShop);
      var map = <String, dynamic>{};
      map['totalAmount'] = 1.99;
      map['desc'] = "木鱼皮肤";
      var data = await HttpUtils.instance.requestNetWorkAy(
          Method.post, HttpApi.submitOrder,
          queryParameters: map);
      if (data != null && data['order'] != null) {
        orderId = data['orderId'];
        AlipayKitPlatform.instance.pay(orderInfo: data['order']);
      } else {
        ToastUtil.showToast("支付出错，请稍后再试");
      }
      // ToastUtil.showToast("当前没有商品无法调用购买逻辑");
    }
  }

  // 根据产品ID获取产品信息
  ProductDetails _getProduct(String productId) {
    return products!.firstWhere((product) => product.id == productId);
  }

  /// 内购的购买更新监听
  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (PurchaseDetails purchase in purchaseDetailsList) {
      debugPrint('-------_>>>${purchase.status} ${purchase.productID}');
      if (purchase.status == PurchaseStatus.pending) {
        // 等待支付完成
        _handlePending();
      } else if (purchase.status == PurchaseStatus.error) {
        // 购买失败
        _handleError(purchase.error);
        EventBus.getDefault().post({
          "isSkinLockKey": Constant.isSkinLockKey,
          "status": false,
        });
      } else if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        EventBus.getDefault().post({
          "isSkinLockKey": Constant.isSkinLockKey,
          "status": true,
        });
        //完成购买, 到服务器验证
        if (PlatformUtils.isAndroid) {
          var googleDetail = purchase as GooglePlayPurchaseDetails;
          print(purchase);
          loadAndroidGetPayInfo(googleDetail);
        } else if (PlatformUtils.isIOS) {
          var appstoreDetail = purchase as AppStorePurchaseDetails;
          print(purchase);
          loadAppleGetPayInfo(appstoreDetail);
        }
      }
    }
    ToastUtil.closeProgress(Get.context!);
  }

  void listenPay(AlipayResp resp) async {
    ToastUtil.closeProgress(Get.context!);
    if (resp.resultStatus == 9000) {
      var map = <String, dynamic>{};
      map['orderId'] = orderId;
      var data = await HttpUtils.instance.requestNetWorkAy(
          Method.post, HttpApi.updateOrder,
          queryParameters: map);
      EventBus.getDefault().post({
        "isSkinLockKey": Constant.isSkinLockKey,
        "status": true,
      });
    } else {
      EventBus.getDefault().post({
        "isSkinLockKey": Constant.isSkinLockKey,
        "status": false,
      });
    }
  }

  /// 购买失败
  void _handleError(IAPError? iapError) {
    ToastUtil.showToast(S.of(Get.context!).startShopFail);
    // ToastUtil.showToast("${S.of(Get.context!).startShopFail}：${iapError?.code} message${iapError?.message}");
  }

  /// 等待支付
  void _handlePending() {
    ToastUtil.showToast("等待支付的逻辑");
  }

  /// Android支付成功的校验
  void loadAndroidGetPayInfo(GooglePlayPurchaseDetails googleDetail) async {
    final originalJson = googleDetail.billingClientPurchase.originalJson;

    Log.d("originalJson:$originalJson");
    // if (await coinRepositroy.checkGooglePaySuccess(originalJson)) {
    //   //校验成功之后执行消耗
    await inAppPurchase.completePurchase(googleDetail);
    // }
  }

  /// Apple支付成功的校验
  void loadAppleGetPayInfo(AppStorePurchaseDetails appstoreDetail) async {
    // if (await coinRepositroy.checkApplyPaySuccess(appstoreDetail)) {
    //   //校验成功之后执行消耗
    await inAppPurchase.completePurchase(appstoreDetail);
    // }
  }

  void dispose() {
    if (PlatformUtils.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }

    inAppPurchase.isAvailable().then((value) {
      if (!value) {
        _paySubs.cancel();
      }
    });

    subscription.cancel();
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
