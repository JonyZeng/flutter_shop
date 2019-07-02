import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart/cart_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartInfoList = [];

  double allPrice = 0;
  int allGoodsCount = 0;
  bool isAllCheck = true;

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;

    allPrice = 0;
    allGoodsCount = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice += (cartInfoList[ival].price * cartInfoList[ival].count);
        allGoodsCount += cartInfoList[ival].count;
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
      allPrice = count * price;
      allGoodsCount += count;
    }
    cartString = json.encode(tempList).toString();
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
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += item['count'] * item['price'];
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
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

  //选中状态的改变
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changedIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changedIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changedIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //全选状态改变
  changeAllCheckBtnCheck(bool isCheck) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //商品数量增加或减少
  addOrReduceAction(CartInfoModel cartItem, String todo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
