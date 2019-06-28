import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home/home_page_context.dart';
import 'package:flutter_shop/routers/application.dart';

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List<Floor> floorList;

  const FloorContent({Key key, this.floorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(context), _otherGoods(context)],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _goodsItem(floorList[0], context),
        Column(
          children: <Widget>[
            _goodsItem(floorList[1], context),
            _goodsItem(floorList[2], context)
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(floorList[3], context),
        _goodsItem(floorList[4], context),
      ],
    );
  }

  Widget _goodsItem(Floor floor, context) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
      onTap: () {
          Application.router.navigateTo(context, '/detail?id=${floor.goodsId}');
        },
        child: Image.network(floor.image),
      ),
    );
  }
}
