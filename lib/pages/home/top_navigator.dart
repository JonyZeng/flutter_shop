
//首页gridView
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home/home_page_context.dart';
import 'package:flutter_shop/routers/application.dart';

class TopNavigator extends StatelessWidget {
  final List<Category> navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItem(BuildContext context, Category item) {
    return InkWell(
        onTap: () {

        },
        child: MediaQuery.removePadding(
          removeBottom: true,
          context: context,
          child: Column(
            children: <Widget>[
              Image.network(
                item.image,
                width: ScreenUtil().setWidth(95),
              ),
              Text(item.mallCategoryName)
            ],
          ),
        ));
  }

  List<Widget> _gridViews(BuildContext context) {
    List<Widget> _gridViewsWidget = [];
    navigatorList.forEach((item) {
      _gridViewsWidget.add(_gridViewItem(context, item));
    });
    return _gridViewsWidget;
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 0)
      this.navigatorList.removeRange(10, this.navigatorList.length);
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),//禁止滑动
          crossAxisCount: 5,
          padding: EdgeInsets.all(5),
          children: _gridViews(context)),
    );
  }
}