import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info_provide.dart';
import 'package:provide/provide.dart';

import 'details/detail_top_area.dart';
import 'details/details_bottom.dart';
import 'details/details_explain.dart';
import 'details/details_tabbar.dart';
import 'details/details_web.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabBar(),
                      DetailsWeb(),
                    ],
                  ),
                ),
                Positioned(
                  child: DetailsBottom(),
                  bottom: 0,
                  left: 0,
                )
              ],
            );
          } else {
            return Center(
              child: Text('正在加载界面。。。。'),
            );
          }
        },
        future: _getBackInfo(context),
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '加载完成';
  }
}
