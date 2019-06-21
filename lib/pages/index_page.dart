import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int _currentIndex = 0;
  var _currentPage;

  @override
  void initState() {
    _currentPage = tabBodies[_currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1330)..init(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 245, 245, 1),
      body: IndexedStack(
        //保护页面状态
        index: _currentIndex,
        children: tabBodies,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: _bottomTabs(),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _currentPage = tabBodies[_currentIndex];
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _bottomTabs() {
    List<BottomNavigationBarItem> bottomTabs = [];
    bottomTabs.add(_bottomItem('首页', CupertinoIcons.home, 0));
    bottomTabs.add(_bottomItem('分类', CupertinoIcons.search, 0));
    bottomTabs.add(_bottomItem('购物车', CupertinoIcons.shopping_cart, 0));
    bottomTabs.add(_bottomItem('会员中心', CupertinoIcons.profile_circled, 0));
    return bottomTabs;
  }

  BottomNavigationBarItem _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(title));
  }
}
