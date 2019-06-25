import 'package:flutter/material.dart';
import '../model/category/category.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId;

  //点击小类切换
  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }

  getChildCategory(String id, List<BxMallSubDto> list) {
    childIndex = 0;
    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
}
