import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/app_manager/app_routes_manager.dart';
import 'package:flutter_sg_mvvm/base/base_view_model.dart';
import 'package:flutter_sg_mvvm/widgets/loading_widget/loading_widget.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget, E extends BaseViewModel> extends State<T> {
  String pageName;
  E viewModel;
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



  //公共UI处理，不用在每个page里面处理loading的逻辑，如不想使用公共部分，直接在子类重写initView()函数
  Widget initView() {
    return Consumer<E>(
      builder: (build, provide, _) {
        print('Consumer-initView');
        print('${viewModel.isLoading}');
        return viewModel.isLoading ? LoadingWidget() : buildView();
      },
    );
  }

  //不同部分UI处理，在子类必须实现buildView()函数
  Widget buildView();


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
    print("deactivate:${pageName}界面");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose 离开${pageName}界面");
    print("销毁${pageName}界面");
  }


}
