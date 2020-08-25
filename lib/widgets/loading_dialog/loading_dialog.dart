import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({
    Key key,
    Color backgroundColor,
    @required this.text,
  }) : super(key: key, backgroundColor: backgroundColor);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: SpinKitRing(
          lineWidth: 2.0,
          color: Color(0xFF262626),
          duration: const Duration(milliseconds: 1000),
          size: 40.0,
        ),
      ),
    );
  }

  static showLoadingDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return LoadingDialog(
//              backgroundColor: Colors.yellow,
            );
          }),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0x01000000), // 自定义遮罩颜色
      transitionDuration: const Duration(milliseconds: 10),
      transitionBuilder: buildMaterialDialogTransitions,
    );

  }

  static cancelLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static Widget buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
