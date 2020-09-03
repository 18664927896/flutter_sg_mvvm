import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/app_manager/app_routes_manager.dart';
import 'package:flutter_sg_mvvm/base/base_state.dart';
import 'package:flutter_sg_mvvm/app_manager/listener_manager.dart';
import 'package:flutter_sg_mvvm/page/shopping_cart/view_model/shopping_cart_view_model.dart';
import 'package:flutter_sg_mvvm/widgets/app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends BaseState<ShoppingCartPage,ShoppingCartViewModel> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageName = "购物车";
    viewModel = ShoppingCartViewModel(context);
    viewModel.refreshData(isShowLoading: true);
    //登录监听
    ListenerManager.addLoginManageListener(loginListener);
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

  @override
  Widget buildView() {
    return GestureDetector(
      onTap: () {
        routerPush(route: AppRoutesManager.mall, popCallback: (data) {});
      },
      child: Container(
        color: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //移除登录监听
    ListenerManager.removeListener(loginListener);
  }
}
