import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager{

  static double width;//屏幕宽度
  static double height;//屏幕高度
  static double contentHeight;//去掉导航栏高度
  static double scale = 1.0;//比例
  static double bottomPadding=0;//刘海屏底部高度
  static double topPadding;//刘海屏顶部高度
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static String httpProxy = '';
  static String channel = '';

  static SharedPreferences prefs;//数据存储
  static PackageInfo packageInfo;//包信息

}