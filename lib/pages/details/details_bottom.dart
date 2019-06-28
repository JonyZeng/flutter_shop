import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(110),
              height: ScreenUtil().setHeight(80),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color:Colors.green,
              alignment: Alignment.center,
              child: Text('加入购物车',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20)),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color:Colors.red,
              alignment: Alignment.center,
              child: Text('立即购买',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
