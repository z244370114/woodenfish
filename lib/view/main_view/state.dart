import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../common/constant.dart';
import '../../widgets/snowflake_painter.dart';

class MainViewState {
  int count = 0;
  late String fishSkin = Constant.dataList.elementAt(0);
  late String toneColour = Constant.toneColour.elementAt(0);
  double opacity = 0.0;

  String fuWnImage = Constant.fuWenList.first;
  bool autoKnock = false;
  bool muicKnock = false;
  bool isVibrate = true;
  double intervalTime = 1;
  Timer? timer;
  bool isAgree = false;
  bool snowflakeValue = true;

  late AudioPlayer audioPlayer;
  late AudioPlayer musicPlayer;

  late List<Widget> animatedList = [];
  int animatedRandoms = 0;
  var randomColors = Colors.white;

  var top = 200.0;
  var left = 0.0;
  var isTrue = false;
  var suspendedText = "";
  var stage = [200, 400, 600, 800, 1000, 1300, 1600, 1900, 2300, 2700];
  var stagePosition = 0;
  var shareFuImage;

  final List<SnowSlake> snowflakes = List.generate(50, (index) => SnowSlake());

  MainViewState() {
    audioPlayer = AudioPlayer();
    musicPlayer = AudioPlayer();
  }
}
