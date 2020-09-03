import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_view_model.dart';


class MineViewModel extends BaseViewModel {
  MineViewModel(BuildContext context) : super(context);


  @override
  Future refreshData({bool isShowLoading = false}) {
    this.isLoading = isShowLoading;
    Future.delayed(Duration(milliseconds: 2000),(){
      this.isLoading = false;
      this.notifyListeners();
    });
  }

}