import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/snowflake_painter.dart';
import 'logic.dart';

class PrayerBeadsViewPage extends StatelessWidget {
  PrayerBeadsViewPage({Key? key}) : super(key: key);

  final logic = Get.put(PrayerBeadsViewLogic());
  final state = Get.find<PrayerBeadsViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerBeadsViewLogic>(builder: (logics) {
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
                      children: [
                        NotificationListener<ScrollStartNotification>(
                          onNotification: (notification) {
                            logic.startKnock();
                            return true;
                          },
                          child: ListView.builder(
                            // controller: state.controller,
                            padding: EdgeInsets.only(top: 0),
                            itemExtent: 200.w,
                            itemCount: 1000,
                            itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.only(top: 10.w),
                              child: Image(
                                height: 200.w,
                                image: AssetImage("assets/images/${state.prayerBeadsSkin}"),
                              ),
                            ),
                          ),
                        ),
                        leftTopMenu(),
                        widgetProgss(),
                        widgetGongde(),
                      ],
                    ),
                  );
                },
              ),
            )
          : Stack(
              alignment: AlignmentDirectional.center,
              clipBehavior: Clip.none,
              children: [
                NotificationListener<ScrollStartNotification>(
                  onNotification: (notification) {
                    logic.startKnock();
                    return true;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemExtent: 200.w,
                    itemCount: 1000,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.only(top: 10.w),
                      child: Image(
                        height: 200.w,
                        image: AssetImage("assets/images/${state.prayerBeadsSkin}"),
                      ),
                    ),
                  ),
                ),
                leftTopMenu(),
                widgetProgss(),
                widgetGongde(),
              ],
            );
    });
  }

  widgetGongde() {
    return Positioned(
      top: Get.height / 2,
      left: Get.width / 2 + 130.w,
      child: Text(
        "${logic.content()}+1",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 36.0.sp,
        ),
      ),
    )
        .animate(
            onInit: (controller) {
              state.gongdeController = controller;
            },
            onPlay: (controller) {},
            onComplete: (controller) {
              controller.reverse();
            })
        .fadeIn(curve: Curves.easeInOutQuint)
        .moveY(end: -10);
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
      right: 30.w,
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
