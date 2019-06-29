import 'package:flutter/material.dart';
import '../model/category/category.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4';
  String subId = '';
  int page = 1;
  String noMoreText = '';

  //点击小类切换
  changeChildIndex(index, String id) {
    childIndex = index;
    subId = id;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  getChildCategory(String id, List<BxMallSubDto> list) {
    childIndex = 0;
    categoryId = id;
    page = 1;
    noMoreText = '';
    subId = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  addPage() {
    page++;
  }

  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
