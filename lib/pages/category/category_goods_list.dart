import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category/category_goods_list.dart';
import 'package:flutter_shop/provide/category_goods_provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _refreshFooterKey =
      new GlobalKey<RefreshFooterState>();
  var scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategoryProvide>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {}

        if (data.categoryGoodsListData.length > 0) {
          return Expanded(
            flex: 1,
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText:
                      Provide.value<ChildCategoryProvide>(context).noMoreText,
                  moreInfo: '加载中。。。',
                  loadReadyText: '上拉加载',
                  key: _refreshFooterKey,
                ),
                key: _easyRefreshKey,
                child: ListView.builder(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return _goodsItem(data, index);
                  },
                  itemCount: data.categoryGoodsListData.length,
                ),
                loadMore: () {
                  _loadMoreGoodsList();
                },
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: Text('商品正在赶来.....'),
            ),
            flex: 1,
          );
        }
      },
    );
  }

  Widget _goodsImage(data, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(data.categoryGoodsListData[index].image),
    );
  }

  Widget _goodsName(data, index) {
    return Container(
      width: ScreenUtil().setWidth(320),
      child: Text(
        data.categoryGoodsListData[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
    );
  }

  Widget _goodPrice(data, index) {
    return Container(
      width: ScreenUtil().setWidth(320),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${data.categoryGoodsListData[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(14)),
          ),
          Text(
            '${data.categoryGoodsListData[index].oriPrice}',
            style: TextStyle(
                color: Colors.black12,
                fontSize: ScreenUtil().setSp(13),
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  Widget _goodsItem(data, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(data, index),
            Column(
              children: <Widget>[
                _goodsName(data, index),
                _goodPrice(data, index)
              ],
            )
          ],
        ),
      ),
    );
  }

  void _loadMoreGoodsList() async {
    Provide.value<ChildCategoryProvide>(context).addPage();
    String categoryId = Provide.value<ChildCategoryProvide>(context).categoryId;
    String subId = Provide.value<ChildCategoryProvide>(context).subId;
    int page = Provide.value<ChildCategoryProvide>(context).page;
    print(
        '_loadMoreGoodsList()===> categoryId=$categoryId, subId=$subId, page=$page ');
    var data = {
      'categoryId': categoryId,
      'categorySubId': subId == '00' ? '' : subId,
      'page': page,
    };
    await request('getMallGoods', fromData: data).then((value) {
      var data = json.decode(value);
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      if (categoryGoodsListModel.data == null) {
        Provide.value<ChildCategoryProvide>(context).changeNoMore('没有数据了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .loadMoreGoodsList(categoryGoodsListModel.data);
      }
    });
  }
}
