import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  GoodsDetailModel goodsDetailModel;
  bool isLeft = true;
  bool isRight = false;

  //tabbar的切换方法
  changeLeftAndRigt(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  //从后台获取商品数据
  getGoodsInfo(String id) async{
    var fromData = {'goodId': id};
    await request('getGoodDetailById', fromData: fromData).then((value) {
      var data = json.decode(value);
      goodsDetailModel = GoodsDetailModel.fromJson(data);
      notifyListeners();
    });
  }
}
