import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/app_manager/app_routes_manager.dart';
import 'package:flutter_sg_mvvm/base/base_view_model.dart';


class ShoppingCartViewModel extends BaseViewModel {
  ShoppingCartViewModel(BuildContext context) : super(context);


  @override
  Future refreshData({bool isShowLoading = false}) {
    this.isLoading = isShowLoading;
    Future.delayed(Duration(milliseconds: 2000),(){
      AppRoutesManager.pushPage({'page':PushPage.goLogin, 'popPage':PopPage.popUp, 'code':-2});
      this.isLoading = false;
      this.notifyListeners();
    });
  }

}