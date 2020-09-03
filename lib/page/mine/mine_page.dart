import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_state.dart';
import 'package:flutter_sg_mvvm/app_manager/listener_manager.dart';
import 'package:flutter_sg_mvvm/page/mine/view_model/mine_view_model.dart';
import 'package:flutter_sg_mvvm/widgets/app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {

  int code;
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends BaseState<MinePage,MineViewModel> with AutomaticKeepAliveClientMixin {


  MineViewModel viewModel;

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageName = "个人中心";
    //登录监听
    ListenerManager.addLoginManageListener(loginListener);
    viewModel = MineViewModel(context);
    viewModel.refreshData(isShowLoading: true);
  }

  void loginListener(dynamic data) {//刷新数据
    print('登录成功，开始刷新数据');
    viewModel.refreshData(isShowLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: CustomAppBar(
          title: pageName,
        ),
        body: initView(),
      ),
    );
  }


  Widget buildView(){

    return Container(
      color:  Colors.orange,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ListenerManager.removeListener(loginListener);//移除监听
  }
}
