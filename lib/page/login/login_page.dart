import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/app_manager/app_manager.dart';
import 'package:flutter_sg_mvvm/base/base_state.dart';
import 'package:flutter_sg_mvvm/app_manager/listener_manager.dart';
import 'package:flutter_sg_mvvm/page/mine/mine_page.dart';
import 'package:flutter_sg_mvvm/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_sg_mvvm/widgets/icons/icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'view_model/login_view_model.dart';

class LoginPage extends StatefulWidget {
  final int code;
  LoginPage({Key key, this.code = -1}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage,LoginViewModel> with AutomaticKeepAliveClientMixin {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageName = "登录";
    AppManager.isLogin = false;

    LoginPage fff = widget;



    if(widget.code == -2) {
      Fluttertoast.showToast(
        msg: '当前账号已在其他设备登录！',
        gravity: ToastGravity.CENTER,
      );
    }
  }
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: pageName,
        leading: IconButton(
          icon: Icon(IconFont.close),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
      body: initView(),
    );
  }


  @override
  Widget initView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () async{
              AppManager.isLogin = true;
              ListenerManager.login({});
              Navigator.of(context).pop(true);
            },
            padding: EdgeInsets.all(10),
            color: Colors.teal,
            child: Text('登录',style: TextStyle(
              color: Colors.white,
            ),),
          ),
          RaisedButton(
            onPressed: () async{
              Navigator.of(context).pop(false);
            },
            padding: EdgeInsets.all(10),
            color: Colors.blueGrey,
            child: Text('关闭',style: TextStyle(
              color: Colors.white,
            ),),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildView() {

  }
}
