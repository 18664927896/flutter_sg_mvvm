import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_view_model.dart';


class MallViewModel extends BaseViewModel {
  MallViewModel(BuildContext context) : super(context);


  @override
  Future refreshData({bool isShowLoading = true}) {
    this.isLoading = isShowLoading;
    Future.delayed(Duration(milliseconds: 2000),(){
      this.isLoading = false;
      this.notifyListeners();
    });
  }

}