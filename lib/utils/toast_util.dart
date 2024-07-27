import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ToastUtil {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.clear
      ..toastPosition = EasyLoadingToastPosition.center
      ..indicatorSize = 22.0
      ..radius = 5.0
      ..lineWidth = 2.5
      ..contentPadding = EdgeInsets.all(8)
      ..progressColor = Colors.green
      ..backgroundColor = Colors.white60
      ..indicatorColor = Colors.red
      ..textColor = Color(0xFF636363)
      ..userInteractions = true
      ..fontSize = 12
      ..boxShadow = [BoxShadow(color: Colors.white)]
      ..dismissOnTap = true;
  }

  static showToast(
    String string, {
    bool toastShort = true, //短时长
    double? fontSize,
    ToastGravity gravity = ToastGravity.CENTER,
    Color? backgroundColor = const Color(0xCC333333),
    Color? textColor = Colors.white,
  }) {
    if (string.length > 1) {
      Fluttertoast.showToast(
          msg: string,
          toastLength: toastShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
          gravity: gravity,
          backgroundColor: backgroundColor,
          textColor: textColor);
    }
  }

  static _closeEasyProgress() {
    EasyLoading.dismiss();
  }

  static _showEasyProgress({String? msg}) {
    /// 避免重复弹出

    EasyLoading.show(status: msg);
  }

  static closeProgress(BuildContext context) {
    Navigator.of(context).pop();
  }

  static showProgress(BuildContext context, {String msg = ""}) {
    try {
      showTransparentDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) {
            return WillPopScope(
              onWillPop: () async {
                return Future.value(true);
              },
              child: ProgressDialog(hintText: msg),
            );
          });
    } catch (e) {
      /// 异常原因主要是页面没有build完成就调用Progress。
      print(e);
    }
  }

  /// 默认dialog背景色为半透明黑色，这里修改源码改为透明
  static Future<T?> showTransparentDialog<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return Theme(data: theme, child: pageChild);
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0x00FFFFFF),
      transitionDuration: Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  static Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

/// 加载中的弹框
class ProgressDialog extends Dialog {
  const ProgressDialog({
    Key? key,
    this.hintText = '',
  }) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 88.0,
          width: 120.0,
          alignment: Alignment.center,
          decoration: const ShapeDecoration(
            color: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: LoadingAnimationWidget.waveDots(
            color: Colors.white,
            size: 60,
          ),
        ),
      ),
    );
  }
}
