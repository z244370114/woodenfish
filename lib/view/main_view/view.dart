import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/snowflake_painter.dart';
import 'logic.dart';

class MainViewPage extends StatelessWidget {
  MainViewPage({Key? key}) : super(key: key);

  final logic = Get.put(MainViewLogic());
  final state = Get.find<MainViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainViewLogic>(builder: (logics) {
      return state.snowflakeValue
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: AnimatedBuilder(
                animation: logic.snowflakeController,
                builder: (_, __) {
                  state.snowflakes.forEach((snow) => snow.fall());
                  return CustomPaint(
                    painter: SnowflakePainter(state.snowflakes),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      clipBehavior: Clip.none,
                      // fit: StackFit.expand,
                      children: [
                        widgetTopFu(),
                        widgetMuYu(),
                        widgetGongde(),
                        widgetGongDeNumber(),
                        leftTopMenu(),
                        widgetProgss(),
                      ],
                    ),
                  );
                },
              ),
            )
          : Stack(
              alignment: AlignmentDirectional.center,
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                widgetTopFu(),
                widgetMuYu(),
                widgetGongde(),
                widgetGongDeNumber(),
                leftTopMenu(),
                widgetProgss(),
              ],
            );
    });
  }

  widgetGongDeNumber() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${logic.content()}:",
            style: TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: "zzFontFamily"),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 3),
            child: AnimatedDigitWidget(
              value: state.count,
              textStyle: const TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: "zzFontFamily"),
            ),
          )
        ],
      ),
    );
  }

  Positioned widgetMuYu() {
    return Positioned(
        left: 0,
        top: 130.0,
        right: 0,
        child: GestureDetector(
            onTap: () {
              if (!state.autoKnock) {
                logic.startKnock();
              }
            },
            child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
              Positioned(
                  child: state.fishSkin == "h8.png"
                      ? const Image(image: AssetImage("assets/images/h9.png"))
                      : const Image(image: AssetImage("assets/images/he.png"))),
              Positioned(
                  bottom: 50.0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: logic.waterAnimation,
                    child: Opacity(
                      opacity: (0.5 - (logic.waterAnimation.value >= 0.25 ? 0.25 : logic.waterAnimation.value)),
                      child: state.fishSkin == "h8.png"
                          ? const Image(image: AssetImage("assets/images/it.png"))
                          : const Image(image: AssetImage("assets/images/is.png")),
                    ),
                  )),
              Center(
                  child: ScaleTransition(
                alignment: Alignment.center,
                scale: logic.fishSkinAnimation,
                child: Image(
                  height: 470,
                  fit: BoxFit.fitHeight,
                  image: AssetImage("assets/images/${state.fishSkin}"),
                ),
              )),
            ])));
  }

  widgetGongde() {
    return Positioned(
        top: state.top,
        left: state.left,
        child: SlideTransition(
          position: logic.floatTextTransitionAnimation,
          child: FadeTransition(
            opacity: logic.floatTextAnimation,
            child: Text("${logic.content()}+1",
                textAlign: TextAlign.center,
                style: TextStyle(color: state.randomColors, fontSize: 18.0, fontFamily: "zzFontFamily")),
          ),
        ));
  }

  Positioned widgetTopFu() {
    return Positioned(
        right: 0,
        top: 0.0,
        child: ScaleTransition(
          scale: logic.fuAnimation,
          alignment: Alignment.center,
          child: Image(
            opacity: logic.fuAnimation,
            image: AssetImage("assets/images/${state.fuWnImage}"),
            width: 150.0,
          ),
        ));
  }

  leftTopMenu() {
    return Positioned(
      top: Get.statusBarHeight,
      left: 20.w,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              logic.muicOpen();
            },
            child: Icon(
              state.muicKnock ? Icons.headset_off_outlined : Icons.headset_mic_outlined,
              size: 50.w,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.w),
          GestureDetector(
            onTap: () {
              logic.vibrateOpen();
            },
            child: Icon(
              state.isVibrate ? Icons.phonelink_erase_outlined : Icons.phone_iphone_outlined,
              size: 50.w,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  widgetProgss() {
    return Positioned(
      top: 100.h,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: CircularProgressIndicator(
                  value: logic.getProgss(),
                  strokeWidth: 12.w,
                  color: Colors.amber,
                  backgroundColor: Colors.white54,
                ),
              ),
              InkWell(
                onTap: () => {logic.jufuClick()},
                child: Text(
                  "集福",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF))
                    .animate()
                    .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                    .slide(),
              ),
            ],
          )
              .animate(
                  // onPlay: (controller) => controller.repeat(),
                  controller: logic.jiFuController)
              .effect(duration: 3000.ms)
              .effect(delay: 750.ms, duration: 1500.ms)
              .shake(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${state.count}/${logic.getStageContent()}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
