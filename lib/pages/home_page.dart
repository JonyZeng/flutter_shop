import 'package:flutter/material.dart';
import 'package:flutter_shop/model/home/home_page_context.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = json.decode(snapshot.data.toString());
          HomePageContextModel homePageContextModel =
              HomePageContextModel.fromJson(data['data']);
          List<Slides> slides = homePageContextModel.slides;
          List<Category> navigatorList = homePageContextModel.category;
          String adPicture =
              homePageContextModel.advertesPicture.pICTUREADDRESS;
          String leaderImage = homePageContextModel.shopInfo.leaderImage;
          String leaderPhone = homePageContextModel.shopInfo.leaderPhone;
          List<Recommend> recommendList = homePageContextModel.recommend;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SwiperDiy(
                  swiperDateList: slides,
                ),
                TopNavigator(
                  navigatorList: navigatorList,
                ),
                AdBanner(
                  adPicture: adPicture,
                ),
                LeaderPhone(
                  leaderImage: leaderImage,
                  leaderPhone: leaderPhone,
                ),
                RecommendWidget(
                  recommendList: recommendList,
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Text('加载中....'),
          );
        }
      },
      future: getHomePageContent(),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List<Slides> swiperDateList;

  const SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDateList[index].image}",
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//首页gridView
class TopNavigator extends StatelessWidget {
  final List<Category> navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItem(BuildContext context, Category item) {
    return InkWell(
        onTap: () {},
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
          crossAxisCount: 5,
          padding: EdgeInsets.all(5),
          children: _gridViews(context)),
    );
  }
}

//广告条
class AdBanner extends StatelessWidget {
  final String adPicture;

  const AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话入口
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(leaderImage),
      ),
    );
  }

  _launchUrl() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//商品推荐模块
class RecommendWidget extends StatelessWidget {
  final List<Recommend> recommendList;

  const RecommendWidget({Key key, this.recommendList}) : super(key: key);

  //头部标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //商品单独项
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index].image),
            Text('￥${recommendList[index].mallPrice}'),
            Text(
              '￥${recommendList[index].price}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(350),
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _item(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(430),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }
}
