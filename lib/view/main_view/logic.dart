import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woodenfish/utils/pub_method.dart';

import '../../common/application.dart';
import '../../common/constant.dart';
import '../../common/route_config.dart';
import '../../generated/l10n.dart';
import '../../utils/event_bus.dart';
import 'state.dart';

class MainViewLogic extends GetxController with SingleGetTickerProviderMixin {
  final MainViewState state = MainViewState();

  late Animation<double> fuAnimation;
  late AnimationController fuController;
  late Animation<double> fishSkinAnimation;
  late AnimationController fishSkinController;
  late Animation<double> waterAnimation;
  late AnimationController waterController;
  late Animation<double> floatTextAnimation;
  late AnimationController floatTextController;
  late Animation<Offset> floatTextTransitionAnimation;
  late AnimationController floatTextTransitionController;

  late AnimationController snowflakeController;

  late AnimationController jiFuController;

  @override
  void onInit() {
    super.onInit();
    jiFuController = AnimationController(vsync: this);
    snowflakeController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
    fuController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    fuAnimation = Tween(begin: 0.0, end: 1.0).animate(fuController);
    fuAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fuController.reverse();
      }
    });

    fishSkinController = AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    fishSkinAnimation = Tween(begin: 1.0, end: 0.98).animate(fishSkinController);
    fishSkinAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fishSkinController.reverse();
      }
    });

    waterController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    waterAnimation = Tween(begin: 0.0, end: 0.65).animate(waterController);
    waterAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        waterController.reset();
      }
    });

    floatTextController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    floatTextAnimation = Tween(begin: 0.0, end: 1.0).animate(floatTextController);
    floatTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        floatTextController.reset();
      }
    });

    floatTextTransitionController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    floatTextTransitionAnimation = Tween(begin: Offset(0, 1), end: Offset(0, -2)).animate(floatTextTransitionController);
    floatTextTransitionAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        floatTextTransitionController.reset();
      }
    });

    EventBus.getDefault().register(null, (event) {
      var read = Application.getStorage.read(event.toString()) ?? "";
      switch (event) {
        case Constant.autoKnockKey:
          state.autoKnock = read;
          if (state.autoKnock) {
            startTimer();
          } else {
            cancelTimer();
          }
          break;
        case Constant.musicKey:
          state.muicKnock = read;
          break;
        case Constant.skinKey:
          state.fishSkin = Constant.dataList[read];
          break;
        case Constant.toneColourKey:
          state.toneColour = read;
          break;
        case Constant.suspendedKey:
          state.suspendedText = read;
          break;
        case Constant.snowflakeKey:
          state.snowflakeValue = read;
          break;
        case Constant.fuKey:
          state.fuWnImage = Constant.fuWenList[read];
          break;
      }
      update();
    });
  }

  Color getRandomColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }

  getData() async {
    var s = Application.getStorage.read(Constant.countKey) ?? 0;
    var stage = Application.getStorage.read(Constant.stagePositionKey) ?? 0;
    state.stagePosition = stage;
    state.isVibrate = Application.getStorage.read(Constant.vibrateKey) ?? true;
    state.count = s;
    var skin = Application.getStorage.read(Constant.skinKey) ?? 0;
    state.fishSkin = Constant.dataList[skin];
    var fuwen = Application.getStorage.read(Constant.fuKey) ?? 0;
    state.fuWnImage = Constant.fuWenList[fuwen];
    String colour = Application.getStorage.read(Constant.toneColourKey) ?? "";
    if (colour.isNotEmpty) {
      state.toneColour = colour;
    }
    bool music = Application.getStorage.read(Constant.musicKey) ?? false;
    state.muicKnock = music;
    if (music) {
      state.musicPlayer.stop();
      state.musicPlayer.play(UrlSource(Constant.music), volume: 0.5);
    } else {
      state.musicPlayer.pause();
      state.musicPlayer.stop();
    }
    double interval = Application.getStorage.read(Constant.intervalTimeKey) ?? 1.0;
    if (interval >= 1) {
      state.intervalTime = interval;
    }
    bool auto = Application.getStorage.read(Constant.autoKnockKey) ?? false;
    state.autoKnock = auto;
    if (state.autoKnock) {
      startTimer();
    } else {
      cancelTimer();
    }
    state.isAgree = Application.getStorage.read(Constant.isAgree) ?? false;
    if (state.isAgree) {
      PubMethodUtils.umengCommonSdkInit();
      // String? deviceId = await PlatformDeviceId.getDeviceId;
      // if (deviceId != null && deviceId.isNotEmpty) {
      //
      // }
    } else {
      show();
    }

    var suspendedKey = Application.getStorage.read(Constant.suspendedKey) ?? "";
    if (suspendedKey.isNotEmpty) {
      state.suspendedText = suspendedKey;
    }

    update();
  }

  void startTimer() {
    Duration duration = Duration(seconds: state.intervalTime.toInt());
    cancelTimer();
    state.timer = Timer.periodic(duration, (timer) {
      startKnock();
    });
  }

  void startKnock() {
    state.audioPlayer.play(UrlSource(Constant.resourceUrl + state.toneColour), volume: 1.0).then((value) async {
      state.count += 1;
      Application.getStorage.write(Constant.countKey, state.count);
      // fuController.forward();
      fishSkinController.forward();
      waterController.forward();
      floatTextController.forward();
      floatTextTransitionController.forward();
      // state.animatedRandoms = Random().nextInt(10 - 0) + 0;
      var random = Random();
      state.top = random.nextInt(230 - 200) + 200;
      state.left = random.nextInt(Get.width.toInt() - 50).toDouble();
      state.randomColors = getRandomColor();
      var canVibrate = await Vibrate.canVibrate;
      if (canVibrate && state.isVibrate) {
        Vibrate.feedback(FeedbackType.success);
      }
      if (state.count >= getStageContent()) {
        jiFuController.reverse();
      }
    });
    // state.fuWnImage = Constant.fuWenList.elementAt(Random().nextInt(5));

    update();
  }

  void cancelTimer() {
    state.timer?.cancel();
  }

  muicOpen() {
    state.muicKnock = !state.muicKnock;
    Application.getStorage.write(Constant.musicKey, state.muicKnock);
    if (state.muicKnock) {
      state.musicPlayer.resume();
    } else {
      state.musicPlayer.stop();
    }
    update();
  }

  vibrateOpen() {
    state.isVibrate = !state.isVibrate;
    Application.getStorage.write(Constant.vibrateKey, state.isVibrate);
    update();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    fuController.dispose();
    fishSkinController.dispose();
    waterController.dispose();
    floatTextController.dispose();
    floatTextTransitionController.dispose();
    snowflakeController.dispose();
    super.onClose();
  }

  show() {
    return showGeneralDialog(
        context: Get.context!,
        barrierDismissible: false,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 200,
                  maxWidth: 220,
                  minHeight: 260,
                ),
                decoration: BoxDecoration(color: Color(0xFF191919), borderRadius: BorderRadius.circular((8))),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(S.of(context).userAgreement,
                          style: TextStyle(
                              color: Colors.white38, fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(S.of(context).userAgreementTip,
                                style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none)),
                            GestureDetector(
                              child: Text("《${S.of(context).userAgreement}》",
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationColor: Colors.white30,
                                    decorationThickness: 1,
                                  )),
                              onTap: () {
                                Constant.isClickAgreement = true;
                                Get.toNamed(
                                    '${RouteConfig.webPage}?title=${S.of(context).userAgreement}&url=${Constant.agreementUrl}');
                              },
                            ),
                            Text("及",
                                style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none)),
                            GestureDetector(
                              child: Text("《${S.of(context).privacyPolicy}》",
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationColor: Colors.white30,
                                    decorationThickness: 1,
                                  )),
                              onTap: () {
                                Constant.isClickAgreement = false;
                                Get.toNamed(
                                    '${RouteConfig.webPage}?title=${S.of(context).privacyPolicy}&url=${Constant.privacyUrl}');
                              },
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Application.getStorage.write(Constant.isAgree, true);
                          state.isAgree = true;
                          PubMethodUtils.umengCommonSdkInit();
                          getData();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Container(
                          width: 200,
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular((45)),
                            color: const Color(0xff424042),
                          ),
                          child: Text(S.of(context).agree,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  String content() {
    if (state.suspendedText.isNotEmpty) {
      return state.suspendedText;
    } else {
      return S.of(Get.context!).meritsAndVirtues;
    }
  }

  int getStageContent() {
    return state.stage[state.stagePosition];
  }

  double getProgss() {
    var progss = state.count / state.stage[state.stagePosition];
    return progss;
  }

  jufuClick() {
    if (state.count > getStageContent()) {
      state.shareFuImage = Constant.fuList[Random().nextInt(Constant.fuList.length)]['bg'];
      showFu();
      jiFuController.stop();
      state.stagePosition += 1;
      Application.getStorage.write(Constant.stagePositionKey, state.stagePosition);
    }
  }

  updatesData() {
    getData();
  }

  showFu() {
    return showGeneralDialog(
        context: Get.context!,
        barrierDismissible: false,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400.w,
                constraints: BoxConstraints(minHeight: 720.w, maxHeight: 800.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/${state.shareFuImage}"),
                      fit: BoxFit.contain,
                      height: 600.w,
                    )
                        .animate(adapter: ValueAdapter(0.5))
                        .shimmer(
                          colors: [
                            const Color(0xFFFFFF00),
                            const Color(0xFF00FF00),
                            const Color(0xFF00FFFF),
                            const Color(0xFF0033FF),
                            const Color(0xFFFF00FF),
                            const Color(0xFFFF0000),
                            const Color(0xFFFFFF00),
                          ],
                        )
                        .animate(onPlay: (controller) => controller.repeat(reverse: true))
                        .saturate(delay: Duration(seconds: 1), duration: Duration(seconds: 2))
                        .then()
                        .fadeOut()
                        .animate()
                        .effect(duration: 3000.ms)
                        .effect(delay: 750.ms, duration: 1000.ms)
                        .slideX(begin: 1)
                        .flipH(begin: -1, alignment: Alignment.centerRight)
                        .scaleXY(begin: 0.75, curve: Curves.easeInOutQuad)
                        .untint(begin: 0.6),
                    SizedBox(height: 20.w),
                    ElevatedButton(
                      onPressed: () async {
                        final image = await rootBundle.load('assets/images/${state.shareFuImage}');
                        final buffer = image.buffer;
                        Share.shareXFiles(
                          [
                            XFile.fromData(
                              buffer.asUint8List(
                                image.offsetInBytes,
                                image.lengthInBytes,
                              ),
                              name: 'Photo.png',
                              mimeType: 'image/png',
                            ),
                          ],
                          text: S.of(Get.context!).shareTxt,
                        );
                      },
                      child: Text(
                        S.of(Get.context!).shareTxt,
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        minimumSize: MaterialStateProperty.all(Size(130, 40)),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.w),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image(
                  image: AssetImage("assets/images/ic_close.png"),
                  fit: BoxFit.contain,
                  height: 64.w,
                  width: 64.w,
                ),
              )
            ],
          );
        });
  }
}
