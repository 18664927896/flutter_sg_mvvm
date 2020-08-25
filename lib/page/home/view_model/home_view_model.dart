import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_view_model.dart';
import 'package:flutter_sg_mvvm/page/home/model/product_model.dart';
import 'package:flutter_sg_mvvm/widgets/loading_dialog/loading_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(BuildContext context) : super(context);
  final subjectMore = new BehaviorSubject<bool>();//更多数据监听
  bool _hasMore = false;
  bool get hasMore => _hasMore;
  set hasMore(bool hasMore) {
    _hasMore = hasMore;
    subjectMore.add(hasMore);
  }
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
    Future.delayed(Duration(milliseconds: 2000),(){
      if(_page==0){
        _dataList.clear();
      }
      for(int i=0;i<10;i++){
        Map<String,dynamic> data = {
          'name': "产品名字",
          'num': 30,
          'price': 33.5,
          'img': 'HTTP',
        };
        _dataList.add(ProductModel.fromJson(data)) ;
      }
      if(_page==0){
        _refreshController.refreshCompleted();
      }else{
        _refreshController.loadComplete();
      }

      if(_dataList.length>=30){
        _refreshController.loadNoData();
      }else{
        _refreshController.resetNoData();
      }
      _page++;
      this.isLoading = false;
      this.notifyListeners();
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