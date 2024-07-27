import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class VipViewPage extends StatelessWidget {
  VipViewPage({Key? key}) : super(key: key);

  final logic = Get.put(VipViewLogic());
  final state = Get.find<VipViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("会员"),
      ),
      body: GetBuilder<VipViewLogic>(builder: (logic) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Image(
                height: 300.w,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/images/bg_top.png"),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 50.w, 0, 30.w),
                child: Text(
                  "会员套餐",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                  ),
                ),
              ),
            ),
            widgetItem(logic),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20.w, 50.w, 0, 10.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "开通VIP：即可享受所有木鱼皮肤",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                      ),
                    ),
                    Text(
                      "开通VIP：即可享受所有佛珠皮肤",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 100.w,
                margin: EdgeInsets.symmetric(vertical: 50.w, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.deepPurple, // 背景颜色
                  borderRadius: BorderRadius.circular(50.r), // 圆角半径
                ),
                child: Center(
                  child: Text(
                    "立即开通会员",
                    style: TextStyle(color: Colors.white, fontSize: 36.sp),
                  ),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .effect(duration: 3000.ms)
                  .effect(delay: 750.ms, duration: 1500.ms)
                  .shake(hz: 3),
            ),
          ],
        );
      }),
    );
  }

  widgetItem(VipViewLogic logic) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 每行显示的列数
          mainAxisSpacing: 20.w, // 网格间垂直方向的间距
          crossAxisSpacing: 30.w, // 网格间水平方向的间距
          childAspectRatio: 5 / 6, // 子项的宽高比
        ),
        itemBuilder: (BuildContext context, int index) {
          var item = state.listItem[index];
          return InkWell(
            onTap: () {
              state.selectIndex = index;
              logic.update();
            },
            child: Container(
              decoration: state.selectIndex == index
                  ? BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10), // 圆角
                      border: Border.all(
                        color: Colors.deepPurple, // 边框颜色
                        width: 4.w, // 边框宽度
                      ),
                    )
                  : BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10), // 圆角
                      border: Border.all(
                        color: Colors.transparent, // 边框颜色
                        width: 4.w, // 边框宽度
                      ),
                    ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item["title"].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.sp,
                    ),
                  ),
                  Text(
                    item["priceTxt"].toString(),
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item["oldPrice"].toString(),
                    style: TextStyle(
                      color: Colors.deepPurple,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.white,
                      decorationThickness: 1,
                      fontSize: 30.sp,
                    ),
                  ),
                ],
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .effect(duration: 3000.ms)
                .effect(delay: 750.ms, duration: 1500.ms)
                .shimmer(),
          );
        },
        itemCount: state.listItem.length,
      ),
    );
  }
}
