import 'package:flutter/material.dart';

import '../../utils/google_in_app_purchase.dart';

class SkinViewState {
  var dataList = [
    {
      "bg": "hd.png",
      "isLock": false,
      "price": '',
      "title": "紫香檀木鱼",
    },
    {
      "bg": "h8.png",
      "isLock": false,
      "price": '',
      "title": "金色紫檀香木鱼",
    },
    {
      "bg": "hg.png",
      "isLock": false,
      "price": '',
      "title": "白色木鱼",
    },
    {
      "bg": "h6.png",
      "isLock": false,
      "price": '',
      "title": "轻木鱼",
    },
    {
      "bg": "h5.png",
      "isLock": false,
      "price": '',
      "title": "蓝色木鱼",
    },
    {
      "bg": "h_.png",
      "isLock": false,
      "price": '',
      "title": "粉色木鱼",
    },
    {
      "bg": "hb.png",
      "isLock": false,
      "price": '',
      "title": "圣诞木鱼",
    },
    {
      "bg": "jw.png",
      "isLock": false,
      "price": '',
      "title": "狮子头木鱼",
    }
  ];

  var prayerBeadsList = [
    {
      "bg": "fc.png",
      "isLock": false,
      "price": '',
      "title": "夜明佛珠",
    },
    {
      "bg": "fe.png",
      "isLock": false,
      "price": '',
      "title": "大理石佛珠",
    },
    {
      "bg": "ff.png",
      "isLock": false,
      "price": '',
      "title": "玻璃珠佛珠",
    },
    {
      "bg": "fg.png",
      "isLock": false,
      "price": '',
      "title": "纹理佛珠",
    },
    {
      "bg": "fh.png",
      "isLock": false,
      "price": '',
      "title": "灰弹佛珠",
    },
    {
      "bg": "fz-3.png",
      "isLock": false,
      "price": '',
      "title": "紫檀木佛珠",
    },
  ];

  var fuList = [
    {
      "bg": "fi.png",
      "isLock": false,
      "title": "身体倍棒",
    },
    {
      "bg": "fk.png",
      "isLock": false,
      "title": "顺利脱单",
    },
    {
      "bg": "fm.png",
      "isLock": false,
      "title": "锦鲤附体",
    },
    {
      "bg": "fo.png",
      "isLock": false,
      "title": "逢考必过",
    },
    {
      "bg": "fq.png",
      "isLock": false,
      "title": "人生巅峰",
    },
    {
      "bg": "fj.png",
      "isLock": false,
      "title": "身体倍棒1",
    },
    {
      "bg": "fl.png",
      "isLock": false,
      "title": "顺利脱单1",
    },
    {
      "bg": "fn.png",
      "isLock": false,
      "title": "锦鲤附体1",
    },
    {
      "bg": "fp.png",
      "isLock": false,
      "title": "逢考必过1",
    },
    {
      "bg": "fr.png",
      "isLock": false,
      "title": "人生巅峰1",
    },
  ];

  List<bool> isSkinLockState = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  int skinIndex = 0;
  int skinSelectIndex = 0;
  int prayerBeadsSkinIndex = 0;
  int prayerBeadsSkinSelectIndex = 0;
  int fuIndex = 0;

  // BannerAd? bannerAd = null;

  late final TabController tabController;

  late GoogleInAppPurchase appPurchase;
  var isRestore = false;

  SkinViewState() {
    appPurchase = GoogleInAppPurchase();
  }
}
