import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  String res = 'value';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request('homePageBelowConten', fromData: 1).then((value) {
      res = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(res),
    );
  }
}
