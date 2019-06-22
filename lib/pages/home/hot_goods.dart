import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home/home_page_below_conten.dart';
import 'package:flutter_shop/service/service_method.dart';

class HotGoodsWidget extends StatefulWidget {
  @override
  _HotGoodsWidgetState createState() => _HotGoodsWidgetState();
}

class _HotGoodsWidgetState extends State<HotGoodsWidget> {
  int page = 1;
  List<HotGoods> hotGoodsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[hotTitle, _wrapList()],
      ),
    );
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(5),
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> hotListWidget = hotGoodsList.map((item) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(
                  item.image,
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${item.mallPrice}'),
                    Text(
                      '￥${item.price}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        children: hotListWidget,
        spacing: 2,
      );
    } else {
      return Text('');
    }
  }

  void _getHotGoods() {
    var fromPage = {'page': page};
    request('homePageBelowConten', fromData: fromPage).then((value) {
      HomePageBelowContenModel homePageBelowContenModel =
          HomePageBelowContenModel.fromJson(json.decode(value));
      List<HotGoods> newGoodList = homePageBelowContenModel.data;

      setState(() {
        hotGoodsList.addAll(newGoodList);
        page++;
      });
    });
  }
}
