import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/category_goods_provide.dart';
import 'package:provide/provide.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        if (data.categoryGoodsListData.length > 0) {
          return Expanded(
            flex: 1,
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _goodsItem(data, index);
                },
                itemCount: data.categoryGoodsListData.length,
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
}
