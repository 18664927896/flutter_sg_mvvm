import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sg_mvvm/page/home/home_page.dart';
import 'package:flutter_sg_mvvm/page/login/login_page.dart';
import 'package:flutter_sg_mvvm/page/mall/mall_page.dart';

enum PushPage {
  goHome,  //去首页
  goHomeAndLogin, //回首页切跳转登录
  goLogin,//登录界面
  goBlackList,//黑明单
  goLimitSale,//限量发售
  goMallHome,//商城首页
  goHomeAndLoginToMall, //回首页切跳转登录
  goMe//个人中心
}


enum PopPage {
  popUp,  //返回上一页
  popNone, //留在当前页
  popUntil, //返回到第一页
}

class AppRoutesManager{

  static StreamController<Map> _appRoutesManageListener =
  new StreamController.broadcast();//界面跳转管理
  static Map<Function, StreamSubscription> listeners = {};

  static Router router;
  /// root 页面
  static const String root = '/';

  static const String home = 'home';

  static const String mall = 'mall';

  static const String login = 'login';

  //添加界面监听
  static void addAppRooutesManageListener(
      void onData(Map notification)) {
    listeners[onData] = _appRoutesManageListener.stream.listen(onData);
  }

  //界面跳转广播
  static void pushPage(Map<String,Object> map){
    _appRoutesManageListener.add(map);
  }

  //取消监听
  static void removeListener(void onData(dynamic data)) {
    StreamSubscription listener = listeners[onData];
    if (listener == null) return;
    listener.cancel();
    listeners.remove(onData);
  }


  //配置路由
  static void configureRoutes(Router router) {//注册路由

    router.define(AppRoutesManager.home, handler: Handler(
      handlerFunc: (BuildContext context,Map<String, dynamic>params){
        return HomePage();
      }),
      transitionType: TransitionType.native,
    );

    router.define(AppRoutesManager.mall, handler: Handler(
        handlerFunc: (BuildContext context,Map<String, dynamic>params){
          return MallPage();
        }),
      transitionType: TransitionType.native,
    );

    router.define(AppRoutesManager.login, handler: Handler(
        handlerFunc: (BuildContext context,Map<String, dynamic>params){
          return LoginPage(
            code: params['code'] != null ? int.tryParse(params['code'][0]) : -1,
          );
        }),
      transitionType: TransitionType.cupertinoFullScreenDialog,
    );


  }

}

