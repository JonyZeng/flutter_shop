import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart/cart_info_model.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  const CartItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBt(),
          _cartGoodImage(),
          _cartGoodName(),
          _cartGoodPrice()
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBt() {
    return Container(
      child: Checkbox(
        value: true,
        onChanged: (bool val) {},
        activeColor: Colors.pink,
      ),
    );
  }

  Widget _cartGoodImage() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  Widget _cartGoodName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[Text(item.goodsName)],
      ),
    );
  }

  Widget _cartGoodPrice() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
