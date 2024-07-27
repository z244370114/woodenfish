import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/router_report.dart';
import 'package:get_storage/get_storage.dart';

import 'common/application.dart';
import 'common/route_config.dart';
import 'generated/l10n.dart';

void main() async {
  await GetStorage.init('woodenfish');
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //全局设置透明
      statusBarIconBrightness: Brightness.light);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  Application.initSp('woodenfish').then((value) => {runApp(const MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1624),
      builder: (context, child) => GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.black,
            iconTheme: const IconThemeData(
              color: Colors.white, // 设置AppBar返回按钮的颜色为红色
            ),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 36.sp),
          ),
          navigationBarTheme: naviBarThemeData(),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        unknownRoute: RouteConfig.getPages[0],
        initialRoute: RouteConfig.initRoute(),
        getPages: RouteConfig.getPages,
        navigatorObservers: [GetXRouterObserver()],
        builder: EasyLoading.init(),
        // scrollBehavior: const MaterialScrollBehavior().copyWith(
        //   scrollbars: true,
        //   dragDevices: _kTouchLikeDeviceTypes,
        // ),
      ),
    );
  }

  ///修改底部菜单栏按钮样式
  NavigationBarThemeData naviBarThemeData() {
    late MaterialStateProperty<IconThemeData?> iconThemeData;
    late MaterialStateProperty<TextStyle?> labelTextStyle;

    iconThemeData = MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.isEmpty) {
        return IconThemeData(
          size: 50.sp,
          color: Colors.white60,
        );
      } else if (states.contains(MaterialState.selected)) {
        return IconThemeData(size: 50.sp, color: Colors.amber);
      }
      return null;
    });

    labelTextStyle = MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.isEmpty) {
        return TextStyle(color: Colors.white60, fontSize: 24.sp);
      } else if (states.contains(MaterialState.selected)) {
        return TextStyle(color: Colors.amber, fontSize: 24.sp);
      }
      return null;
    });

    return NavigationBarThemeData(iconTheme: iconThemeData, labelTextStyle: labelTextStyle, indicatorColor: Colors.white24);
  }
}

class GetXRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    RouterReportManager.reportCurrentRoute(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    RouterReportManager.reportRouteDispose(route);
  }
}
