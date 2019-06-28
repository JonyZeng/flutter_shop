import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String goodsDetails = Provide.value<DetailsInfoProvide>(context)
        .goodsDetailModel
        .data
        .goodInfo
        .goodsDetail;
    print(goodsDetails);
    String web =
        "<div><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_5060.jpg\"/></div>";
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(data: web),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(15),
            child: Text('暂时没有数据 '),
          );
        }
      },
    );
  }
}
