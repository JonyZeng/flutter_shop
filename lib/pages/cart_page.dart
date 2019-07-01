import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart/cart_info_model.dart';
import 'package:flutter_shop/provide/cart_prodive.dart';
import 'package:provide/provide.dart';

import 'cart/cart_bottom.dart';
import 'cart/cart_item.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: FutureBuilder(
          future: _getCarInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CartInfoModel> cartList =
                  Provide.value<CartProvide>(context).cartInfoList;

              return Stack(
                children: <Widget>[
                  ListView.builder(
                    itemBuilder: (context, index) {
                      print(cartList[index].goodsName);
                      return CartItem(
                        item: cartList[index],
                      );
                    },
                    itemCount: cartList.length,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  )
                ],
              );
            } else {
              return Text('正在加载');
            }
          },
        ));
  }

  Future<String> _getCarInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return "end";
  }
}
