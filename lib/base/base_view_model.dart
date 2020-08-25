import 'package:flutter/widgets.dart';

///所有viewModel的父类，提供一些公共功能
///author:liuhc
abstract class BaseViewModel  with ChangeNotifier {

  BaseViewModel(this.context);

  BuildContext context;
  //是否正在加载
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    if(_isLoading!=isLoading){
      _isLoading= isLoading;
      this.notifyListeners();
    }
    
  }
  ///刷新数据
  @protected
  Future refreshData({bool isShowLoading = false});

}