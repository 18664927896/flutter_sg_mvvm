import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/app_manager/app_manager.dart';
import 'package:flutter_sg_mvvm/app_manager/app_routes_manager.dart';

abstract class BaseState<T extends StatefulWidget> extends State {
  String pageName;
  bool isLeave = false; //是否离开
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 500), () {
      print("initState 进入${pageName}界面");
    });
  }

  @override
  Widget build(BuildContext context) {
    return build(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies: ${pageName}界面");
  }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget: ${pageName}界面");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
//    if (isLeave) {
//      isLeave = false;
//      print("deactivate 进入${pageName}界面");
//    } else {
//      isLeave = true;
//      print("deactivate 离开${pageName}界面");
//    }

    print("deactivate:${pageName}界面");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose 离开${pageName}界面");
    print("销毁${pageName}界面");
  }

  //跳转界面
  void push({Widget page, Function popCallback}) {
    print("push: 离开${pageName}界面");

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    })).then((data) {
      print("pop 进入${pageName}界面");
      if (popCallback != null) {
        popCallback(data);
      }
    });
  }

  //路由跳转
  void routerPush({String route, Function popCallback}) {
    print("routerPush: 离开${pageName}界面");
    AppRoutesManager.router.navigateTo(context, route).then((data) {
      print("pop 进入${pageName}界面");
      if (popCallback != null) {
        popCallback(data);
      }
    });
  }
}
