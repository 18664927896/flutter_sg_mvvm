import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/app_manager/app_routes_manager.dart';
import 'package:flutter_sg_mvvm/base/base_state.dart';
import 'package:flutter_sg_mvvm/widgets/app_bar/custom_app_bar.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends BaseState<MinePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageName = "个人中心";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: pageName,
      ),
      body: GestureDetector(
        onTap: () {
          routerPush(route: AppRoutesManager.mall, popCallback: (data) {});
        },
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
