import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/provide/category_goods_provide.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategoryProvide();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var providers = Providers();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategoryProvide>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
