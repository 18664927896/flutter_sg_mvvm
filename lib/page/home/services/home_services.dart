

import 'package:flutter/cupertino.dart';
import 'package:flutter_sg_mvvm/config/api.dart';
import 'package:flutter_sg_mvvm/network/network.dart';
import 'package:flutter_sg_mvvm/page/home/model/product_model.dart';

class HomeServices{

  static Future<dynamic> collectionProduct({
    @required String productId,
    @required int moduleType,
  }) async {
    final res = await Network.post(
      Api.homeList,
      data: {
        'productId': productId,
      },
    );
    return res.data;
  }

  static Future<List<ProductModel>> getHomeList() async {

    List<ProductModel> _dataList = [];
   await Future.delayed(Duration(milliseconds: 2000),(){
      for(int i=0;i<10;i++){
        Map<String,dynamic> data = {
          'name': "产品名字",
          'num': 30,
          'price': 33.5,
          'img': 'HTTP',
        };
        _dataList.add(ProductModel.fromJson(data)) ;
      }

    });

    return _dataList;

//    final res = await Network.get(Api.homeList);
//    return res.data;
  }

}