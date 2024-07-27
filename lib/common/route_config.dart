import 'package:get/get.dart';
import 'package:woodenfish/view/introduction_view/view.dart';
import '../view/about_view/view.dart';
import '../view/home_view/view.dart';
import '../view/main_view/view.dart';
import '../view/setting_view/view.dart';
import '../view/vip_view/view.dart';
import '../view/web_view/view.dart';
import '../widgets/web_page.dart';
import 'application.dart';
import 'c_key.dart';

class RouteConfig {
  ///启动界面
  // static const String entranceApp = "/";
  ///主页面
  static const String home = "/";
  static const String main = "/main";
  static const String guide = "/guide";
  static const String setting = "/setting";
  static const String about = "/about";
  static const String vip = "/vipViewPage";
  static const String introduction = "/introduction";
  static const String webPage = "/webPage";

  ///登录界面
  static const String login = "/login";

  ///空白界面
  static const String notFound = "/notfound";

  ///别名映射页面
  static final List<GetPage> getPages = [
    // GetPage(name: notFound, page: () => const WidgetNotFound()),
    // GetPage(name: guide, page: () => GuidePage()),
    GetPage(name: main, page: () => MainViewPage()),
    GetPage(name: home, page: () => HomeViewPage()),
    GetPage(name: main, page: () => MainViewPage()),
    GetPage(name: setting, page: () => SettingViewPage()),
    GetPage(name: about, page: () => AboutViewPage()),
    GetPage(name: introduction, page: () => IntroductionViewPage()),
    GetPage(name: webPage, page: () => WebViewPage()),
    GetPage(name: vip, page: () => VipViewPage()),
  ];

  /// 判断启动入口
  static String initRoute() {
    String page = RouteConfig.home;
    if (Application.getStorage.hasData(CKey.runOne)) {
      if (Application.getStorage.hasData(CKey.loginState) &&
          Application.getStorage.read(CKey.loginState)) {
        page = RouteConfig.home;
      } else {
        page = RouteConfig.login;
      }
    } else {
      page = RouteConfig.guide;
    }
    return RouteConfig.home;
  }
}
