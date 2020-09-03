import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_view_model.dart';
import 'package:flutter_sg_mvvm/page/home/model/product_model.dart';
import 'package:flutter_sg_mvvm/page/home/services/home_services.dart';
import 'package:flutter_sg_mvvm/widgets/loading_dialog/loading_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(BuildContext context) : super(context);

  // 页数
  int _page = 0;
  int get page => _page;
  set page(int page) {
    _page = page;
  }

  List <ProductModel> _dataList = [];
  List<ProductModel> get dataList => _dataList;
  set dataList(List<ProductModel> arr) {
    _dataList = arr;
    this.notifyListeners();
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;

  @override
  Future refreshData({bool isShowLoading = false}) {

    this.isLoading = isShowLoading;

    HomeServices.getHomeList().then((data){
      if(_page==0){
        _dataList.clear();
        _refreshController.refreshCompleted();
      }else{
        _refreshController.loadComplete();
      }

      _dataList.addAll(data) ;

      if(_dataList.length>=30){
        _refreshController.loadNoData();
      }else{
        _refreshController.resetNoData();
      }
      _page++;
      this.isLoading = false;
      this.notifyListeners();

    }).catchError((e){
      print("获取首页列表异常$e");
    });
  }

  //收藏或取消收藏
  Future collectionProduc(int index){
    LoadingDialog.showLoadingDialog(context);
    Future.delayed(Duration(milliseconds: 2000),(){
      ProductModel model = _dataList[index];
      model.isCollection = !model.isCollection;
      this.notifyListeners();
      LoadingDialog.cancelLoadingDialog(context);
    });
  }
}