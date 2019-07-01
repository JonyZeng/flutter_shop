import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart/cart_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartInfoList = [];

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHave = true;
      }
      ival++;
    });
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      ival = 0;
      tempList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
//    print('数据。。。。。$cartString');
//    print('模型。。。。。$cartInfoList.');
    preferences.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    cartInfoList = [];
    print('清空完成。。。。。');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    cartInfoList = [];
    if (cartString == null) {
      cartInfoList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        print('$item');
        cartInfoList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  //删除购物车单个商品
  delCartGoodsByGoodsId(String goodsId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    var tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
