import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category/category.dart';
import 'package:flutter_shop/model/category/category_goods_list.dart';
import 'package:flutter_shop/provide/category_goods_provide.dart';
import 'package:flutter_shop/provide/child_category_provide.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategoryProvide>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(100),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _rightInkWell(
                  index, childCategory.childCategoryList[index]);
            },
            itemCount: childCategory.childCategoryList.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }

  Widget _rightInkWell(index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategoryProvide>(context).childIndex
        ? true
        : false);
    return InkWell(
      onTap: () {
        Provide.value<ChildCategoryProvide>(context)
            .changeChildIndex(index, item.mallSubId);

        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              color: isClick ? Colors.pink : Colors.black,
              fontSize: ScreenUtil().setSp(14)),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) async {
    String categoryId = Provide.value<ChildCategoryProvide>(context).categoryId;
    print('categoryId=$categoryId,categorySubId=$categorySubId');
    var data = {
      'categoryId': categoryId,
      'categorySubId': categorySubId == '00' ? "" : categorySubId,
      'page': 1
    };
    await request('getMallGoods', fromData: data).then((value) {
      var data = json.decode(value);
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      if (categoryGoodsListModel.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(categoryGoodsListModel.data);
      }
    });
  }
}
