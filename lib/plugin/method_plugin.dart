import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woodenfish/utils/platform_utils.dart';

class MethodPlugin {
  static const MethodChannel _channel = MethodChannel('com.xhx.woodenfish/plugin');

  static void share() {
    _channel.invokeMethod('share');
  }

  static void googlePlay() {
    _channel.invokeMethod('googlePlay');
  }

  static Future<String> getVersionName() async {
    var versionName = await _channel.invokeMethod('getVersionName');
    return versionName;
  }

  static Future<String> getVersionCode() async {
    return await _channel.invokeMethod('getVersionCode');
  }

  static Future<String> getAppChannelId() async {
    return await _channel.invokeMethod('getAppChannelId');
  }

  static Future<bool> isGoogleChannel() async {
    var name = await _channel.invokeMethod('getAppChannelId');
    return name == "google";
  }

  static void sikpPlay() async {
    var url;
    if (PlatformUtils.isAndroid) {
      var channelName = await _channel.invokeMethod('getAppChannelId');
      switch (channelName) {
        case "huawei":
          url = Uri.parse("appmarket://details?id=com.xhx.woodenfish");
          break;
        case "google":
          url = Uri.parse("market://details?id=com.xhx.woodenfish");
          break;
        case "xiaomi":
          url = Uri.parse("mimarket://details?id=com.xhx.woodenfish");
          break;
        default:
          url = Uri.parse("market://details?id=com.xhx.woodenfish");
          break;
      }
    } else if (PlatformUtils.isIOS) {
      url = Uri.parse("https://apps.apple.com/us/app/id6504429460");
    }
    await launchUrl(url);
  }
}
