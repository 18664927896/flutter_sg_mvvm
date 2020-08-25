import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_state.dart';
import 'package:flutter_sg_mvvm/page/mine/mine_page.dart';
import 'package:flutter_sg_mvvm/widgets/app_bar/custom_app_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageName = "登录";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: pageName,
      ),
      body: GestureDetector(
        onTap:(){
//          Navigator.push(context, MaterialPageRoute(
//              builder: (BuildContext context){
//                return MinePage();
//              }
//          )).then((value){
//
//            print("deactivate 进入${pageName}界面");
//          });

          push(page: MinePage(),popCallback: (dada){

          });
        },
        child: Container(
          color:  Colors.red,
        ),
      ),
    );
  }
}
