import 'package:flutter/material.dart';

///页面保活方法
class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage(this.child, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KeepAliveState();
  }
}

class _KeepAliveState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
