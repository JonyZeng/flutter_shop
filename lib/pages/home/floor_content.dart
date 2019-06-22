import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home/home_page_context.dart';

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List<Floor> floorList;

  const FloorContent({Key key, this.floorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorList[1]),
            _goodsItem(floorList[2])
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorList[3]),
        _goodsItem(floorList[4]),
      ],
    );
  }

  Widget _goodsItem(Floor floor) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(floor.image),
      ),
    );
  }
}