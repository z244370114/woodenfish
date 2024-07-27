import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import 'logic.dart';

class SkinViewPage extends StatelessWidget {
  SkinViewPage({Key? key}) : super(key: key);

  final logic = Get.put(SkinViewLogic());
  final state = Get.find<SkinViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkinViewLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).skin),
            // actions: [
            //   Visibility(
            //     visible: state.isRestore,
            //     child: TextButton(
            //         onPressed: () {
            //           if (state.appPurchase != null) {
            //             state.appPurchase.restore();
            //           }
            //         },
            //         child: Text(S.current.restore,
            //             style: const TextStyle(color: Colors.white54))),
            //   )
            // ],
            bottom: TabBar(
              controller: state.tabController,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.amber,
              labelColor: Colors.amber,
              tabs: <Widget>[Tab(text: S.of(context).skin), Tab(text: S.of(context).prayerBeads), Tab(text: S.of(context).fu)],
            ),
          ),
          body: TabBarView(
            controller: state.tabController,
            children: [
              tabWidget1(logic),
              tabWidget2(),
              tabWidget3(),
              // Container(),
            ],
          ),
        );
      },
    );
  }

  tabWidget1(SkinViewLogic logic) {
    return GridView.builder(
        itemCount: state.dataList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 每行/列的网格数量
            mainAxisSpacing: 2.w, // 主轴方向的间距
            crossAxisSpacing: 2.w, // 交叉轴方向的间距
            mainAxisExtent: 300.w),
        itemBuilder: (context, index) {
          var item = state.dataList[index];
          return InkWell(
            onTap: () {
              logic.purchase(index);
            },
            child: Card(
              elevation: 1,
              clipBehavior: Clip.hardEdge,
              color: state.skinIndex == index ? Colors.white10 : Colors.black12,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/${item['bg']}"),
                        width: 150.w,
                        height: 150.w,
                        fit: BoxFit.fill,
                      ),
                      Text(item['title'].toString(), style: const TextStyle(color: Colors.grey)),
                      // Text(item['price'].toString()),
                    ],
                  ),
                  // Visibility(
                  //   visible: item['isLock'] as bool,
                  //   child: Positioned(
                  //     top: 10.w,
                  //     right: 10.w,
                  //     child: const Icon(
                  //       Icons.lock,
                  //       color: Colors.amber,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        });
  }

  GridView tabWidget2() {
    return GridView.builder(
        itemCount: state.prayerBeadsList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 每行/列的网格数量
            mainAxisSpacing: 2.w, // 主轴方向的间距
            crossAxisSpacing: 2.w, // 交叉轴方向的间距
            mainAxisExtent: 300.w),
        itemBuilder: (context, index) {
          var item = state.prayerBeadsList[index];
          return InkWell(
            onTap: () {
              logic.prayerBeadsPurchase(index);
            },
            child: Card(
              elevation: 1,
              clipBehavior: Clip.hardEdge,
              color: state.prayerBeadsSkinIndex == index ? Colors.white10 : Colors.black12,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/${item['bg']}"),
                        width: 150.w,
                        height: 150.w,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item['title'].toString(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      // Text(item['price'].toString()),
                    ],
                  ),
                  Visibility(
                    visible: item['isLock'] as bool,
                    child: Positioned(
                      top: 10.w,
                      right: 10.w,
                      child: Icon(
                        Icons.lock,
                        color: Colors.amber,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  GridView tabWidget3() {
    return GridView.builder(
        itemCount: state.fuList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 每行/列的网格数量
            mainAxisSpacing: 5.w, // 主轴方向的间距
            crossAxisSpacing: 5.w, // 交叉轴方向的间距
            mainAxisExtent: 580.w),
        itemBuilder: (context, index) {
          var item = state.fuList[index];
          return InkWell(
            onTap: () {
              logic.fu(index);
            },
            child: Card(
              elevation: 1,
              color: state.fuIndex == index ? Colors.white10 : Colors.black45,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['title'].toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: state.fuIndex == index ? Colors.white : Colors.white54)),
                  Image(
                    image: AssetImage("assets/images/${item['bg']}"),
                    fit: BoxFit.contain,
                    height: 500.w,
                  ),
                ],
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
                  // .tint(color: const Color(0xFF80DDFF))
                  // .then()
                  // .blurXY(end: 24)
                  .fadeOut(),
            ),
          );
        });
  }
}
