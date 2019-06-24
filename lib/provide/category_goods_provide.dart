import 'package:flutter/material.dart';
import '../model/category/category_goods_list.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryGoodsListData> categoryGoodsListData = [];

  //点击大类时更换商品列表
  getGoodsList(List<CategoryGoodsListData> list) {
    categoryGoodsListData = list;
    notifyListeners();
  }
}
