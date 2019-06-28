import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo = Provide.value<DetailsInfoProvide>(context)
            .goodsDetailModel
            .data
            .goodInfo;
        if (goodsInfo != null) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _goodsImage(goodsInfo.image1),
                  _goodsName(goodsInfo.goodsName),
                  _goodsNum(goodsInfo.goodsSerialNumber),
                  _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
                ],
              ),
            ),
          );
        } else {
          return Text('正在加载中。。。。');
        }
      },
    );
  }

  //商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号： $num',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  //商品加钱
  Widget _goodsPrice(double oriPrice, double presentPrice) {
    return Row(
      children: <Widget>[
        Text(
          '￥$presentPrice',
          style: TextStyle(
              color: Colors.deepOrange, fontSize: ScreenUtil().setSp(25)),
        ),
        Text(
          '市场价：',
          style: TextStyle(
              color: Colors.black54, fontSize: ScreenUtil().setSp(18)),
        ),
        Text(
          '$oriPrice',
          style: TextStyle(
              color: Colors.grey,
              fontSize: ScreenUtil().setSp(18),
              decoration: TextDecoration.lineThrough),
        )
      ],
    );
  }
}
