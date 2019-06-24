import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category/category.dart';
import 'package:flutter_shop/model/category/category_goods_list.dart';
import 'package:flutter_shop/provide/category_goods_provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryData> categoryDataList = [];
  var listIndex = 0;

  List<CategoryGoodsListData> categoryGoodsListData;

  @override
  void initState() {
    _getCateGory();
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: categoryDataList.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }


  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        var childList = categoryDataList[index].bxMallSubDto;
        Provide.value<ChildCategoryProvide>(context)
            .getChildCategory(childList);
        setState(() {
          listIndex = index;
        });
        _getGoodsList(categoryId: categoryDataList[index].mallCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          categoryDataList[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(14)),
        ),
      ),
    );
  }

  void _getCateGory() async {
    await request('getCategory').then((value) {
      CategoryModel categoryModel = CategoryModel.fromJson(json.decode(value));
      //TODO 这里要状态管理机获取最新的list
      setState(() {
        categoryDataList = categoryModel.data;
      });
      Provide.value<ChildCategoryProvide>(context)
          .getChildCategory(categoryDataList[0].bxMallSubDto);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'CategorySubId': "",
      'page': 1
    };
    await request('getMallGoods', fromData: data).then((value) {
      var data = json.decode(value);
      CategoryGoodsListModel categoryGoodsListModel =
      CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(categoryGoodsListModel.data);
    });
  }
}
