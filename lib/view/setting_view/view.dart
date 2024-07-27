import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/application.dart';
import '../../common/constant.dart';
import '../../generated/l10n.dart';
import '../../utils/event_bus.dart';
import 'logic.dart';

class SettingViewPage extends StatelessWidget {
  SettingViewPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingViewLogic());
  final state = Get.find<SettingViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).setting),
        ),
        body: GetBuilder<SettingViewLogic>(builder: (logics) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).bgm, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "zzFontFamily")),
                    Switch.adaptive(
                        activeColor: Colors.amber,
                        inactiveTrackColor: Colors.grey,
                        value: state.switchMusicValue,
                        onChanged: (value) {
                          state.switchMusicValue = !state.switchMusicValue;
                          Application.getStorage.write(Constant.musicKey, state.switchMusicValue);
                          EventBus.getDefault().post(Constant.musicKey);
                          logic.update();
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).automaticTapping,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "zzFontFamily")),
                    Switch.adaptive(
                        activeColor: Colors.amber,
                        inactiveTrackColor: Colors.grey,
                        value: state.switchAutoValue,
                        onChanged: (value) {
                          state.switchAutoValue = !state.switchAutoValue;
                          Application.getStorage.write(Constant.autoKnockKey, state.switchAutoValue);
                          EventBus.getDefault().post(Constant.autoKnockKey);
                          logic.update();
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).snowflakeText,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: "zzFontFamily")),
                    Switch.adaptive(
                        activeColor: Colors.amber,
                        inactiveTrackColor: Colors.grey,
                        value: state.snowflakeValue,
                        onChanged: (value) {
                          state.snowflakeValue = !state.snowflakeValue;
                          Application.getStorage.write(Constant.snowflakeKey, state.snowflakeValue);
                          EventBus.getDefault().post(Constant.snowflakeKey);
                          logic.update();
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                child: Row(
                  children: [
                    Text(S.of(context).suspendedText,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: "zzFontFamily"),
                        textAlign: TextAlign.start),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {showDialogs()},
                        child: Container(
                          padding: EdgeInsets.all(15.w),
                          margin: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(5.r), // 圆角半径
                          ),
                          child: Text(S.of(context).suspendedTextTip,
                              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "zzFontFamily"),
                              textAlign: TextAlign.start),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              //   child: Row(
              //     children: [
              //       Text(S.of(context).skin,
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 16,
              //               fontFamily: "zzFontFamily"),
              //           textAlign: TextAlign.start),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: SizedBox(
              //       height: 150.0,
              //       child: GridView(
              //         padding: const EdgeInsets.symmetric(vertical: 0),
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 5,
              //         ),
              //         children: Constant.dataList
              //             .map((item) => InkWell(
              //                   borderRadius:
              //                       const BorderRadius.all(Radius.circular(50)),
              //                   child: Container(
              //                     alignment: Alignment.center,
              //                     margin: const EdgeInsets.all(8),
              //                     decoration: Constant.dataList.indexOf(item) ==
              //                             state.skinIndex
              //                         ? const BoxDecoration(
              //                             shape: BoxShape.circle,
              //                             color: Colors.white70,
              //                           )
              //                         : const BoxDecoration(
              //                             shape: BoxShape.circle,
              //                             color: Color(0xff424042),
              //                           ),
              //                     child: Image(
              //                       image: AssetImage("assets/images/$item"),
              //                       width: 56.0,
              //                       height: 56.0,
              //                       fit: BoxFit.fill,
              //                     ),
              //                   ),
              //                   onTap: () {
              //                     state.skinIndex =
              //                         Constant.dataList.indexOf(item);
              //                     Application.getStorage
              //                         .write(Constant.skinKey, item);
              //                     EventBus.getDefault().post(Constant.skinKey);
              //                     logic.update();
              //                   },
              //                 ))
              //             .toList(),
              //       )),
              // ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                child: Row(
                  children: [
                    Text(S.of(context).timbre,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "zzFontFamily"),
                        textAlign: TextAlign.start),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                    height: 150.0,
                    child: GridView(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                      ),
                      children: Constant.toneColour
                          .map((item) => InkWell(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(8),
                                  transformAlignment: Alignment.center,
                                  decoration: Constant.toneColour.indexOf(item) == state.toneColourIndex
                                      ? const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.amber,
                                        )
                                      : const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff424042),
                                        ),
                                  child: Text(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                    logic.getToneColour(item),
                                  ),
                                ),
                                onTap: () {
                                  state.toneColourIndex = Constant.toneColour.indexOf(item);
                                  Application.getStorage.write(Constant.toneColourKey, item);
                                  EventBus.getDefault().post(Constant.toneColourKey);
                                  logic.update();
                                },
                              ))
                          .toList(),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                child: Row(
                  children: [
                    Text(S.of(context).tapInterval(state.sliderValue.toStringAsFixed(1).toString()),
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: "zzFontFamily"),
                        textAlign: TextAlign.start),
                  ],
                ),
              ),
              Slider(
                activeColor: Colors.white,
                inactiveColor: Colors.white38,
                max: 3,
                min: 1,
                value: state.sliderValue,
                onChanged: (value) {
                  state.sliderValue = value;
                  Application.getStorage.write(Constant.intervalTimeKey, value);
                  EventBus.getDefault().post(Constant.intervalTimeKey);
                  logic.update();
                },
              )
            ],
          );
        }));
  }

  showDialogs() {
    state.textEditingController.text = state.suspendedText;
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog.adaptive(
            title: Text(S.of(context).suspendedText),
            content: TextField(
              controller: state.textEditingController,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(S.of(context).cancel),
                onPressed: () => {Navigator.of(context).pop()},
              ),
              TextButton(
                child: Text(S.of(context).agree),
                onPressed: () {
                  logic.setSuspended();
                },
              ),
            ],
          );
        });
  }
}
