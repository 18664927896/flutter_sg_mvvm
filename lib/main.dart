import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sg_mvvm/app_manager/app_routes_manager.dart';
import 'package:flutter_sg_mvvm/network/network.dart';
import 'package:flutter_sg_mvvm/utils/packetcapture/packetcapture.dart';
import 'package:flutter_sg_mvvm/widgets/main_bottom_bar/main_bottom_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app_manager/app_manager.dart';

void main() {
// 初始化路由
  final router = Router();
  AppRoutesManager.configureRoutes(router);
  AppRoutesManager.router = router;
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Packetcapture.initUniLinks(callBack: (host,port){
      Network.setHttpProxy(host, port);
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
//        headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
//        springDescription: SpringDescription(
//            stiffness: 170,
//            damping: 16,
//            mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api
        maxOverScrollExtent: 100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
        footerTriggerDistance: -60, // 底部触发刷新的越界距离
        maxUnderScrollExtent: 100, // 底部最大可以拖动的范围
        enableScrollWhenRefreshCompleted:
        true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
        enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
        hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
        enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
        child: MaterialApp(
          title: 'mvvm demo',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            //此处
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('en'),
          supportedLocales: [
            //此处
            const Locale('zh', 'CH'),
          ],
          home: MainBottomBar(),
          builder: (context, child) {
            return MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
          onGenerateRoute: AppRoutesManager.router.generator,
          navigatorKey: AppManager.navigatorKey,
        ));
  }
}



