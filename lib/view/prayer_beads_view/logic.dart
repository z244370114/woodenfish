import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../common/application.dart';
import '../../generated/l10n.dart';
import '../../utils/event_bus.dart';
import 'state.dart';
import '../../common/constant.dart';

class PrayerBeadsViewLogic extends GetxController
    with SingleGetTickerProviderMixin {
  final PrayerBeadsViewState state = PrayerBeadsViewState();

  late AnimationController snowflakeController;
  late AnimationController jiFuController;

  @override
  void onInit() {
    super.onInit();
    jiFuController = AnimationController(vsync: this);
    state.gongdeController = AnimationController(vsync: this);
    snowflakeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();

    EventBus.getDefault().register(null, (event) {
      var read = Application.getStorage.read(event.toString()) ?? "";
      switch (event) {
        case Constant.musicKey:
          state.muicKnock = read;
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
        case Constant.prayerBeadsKey:
          state.prayerBeadsSkin = Constant.prayerBeadsList[read];
          break;
      }
      update();
    });
    updatesData();
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
      state.shareFuImage =
          Constant.fuList[Random().nextInt(Constant.fuList.length)]['bg'];
      showFu();
      jiFuController.stop();
      state.stagePosition += 1;
      Application.getStorage
          .write(Constant.stagePositionKey, state.stagePosition);
    }
  }

  void startKnock() async {
    state.audioPlayer
        .play(UrlSource(Constant.resourceUrl + state.toneColour), volume: 1.0)
        .then((value) async {
      state.count += 1;
      Application.getStorage.write(Constant.countKey, state.count);
      state.gongdeController.forward();
      var canVibrate = await Vibrate.canVibrate;
      if (canVibrate && state.isVibrate) {
        Vibrate.feedback(FeedbackType.success);
      }
      if (state.count >= getStageContent()) {
        jiFuController.reverse();
      }
    });
    update();
  }

  updatesData() {
    var s = Application.getStorage.read(Constant.countKey) ?? 0;
    state.count = s;
    var stage = Application.getStorage.read(Constant.stagePositionKey) ?? 0;
    state.stagePosition = stage;
    state.isVibrate = Application.getStorage.read(Constant.vibrateKey) ?? true;
    bool music = Application.getStorage.read(Constant.musicKey) ?? false;
    state.muicKnock = music;
    var skin = Application.getStorage.read(Constant.prayerBeadsKey) ?? 0;
    state.prayerBeadsSkin = Constant.prayerBeadsList[skin];
    if (music) {
      state.musicPlayer.stop();
      state.musicPlayer.play(UrlSource(Constant.music), volume: 0.5);
    } else {
      state.musicPlayer.pause();
      state.musicPlayer.stop();
    }
    update();
  }

  showFu() {
    return showGeneralDialog(
        context: Get.context!,
        barrierDismissible: false,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
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
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true))
                        .saturate(
                            delay: Duration(seconds: 1),
                            duration: Duration(seconds: 2))
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
                        final image = await rootBundle
                            .load('assets/images/${state.shareFuImage}');
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        minimumSize: MaterialStateProperty.all(Size(130, 40)),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
