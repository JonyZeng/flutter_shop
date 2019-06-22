import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/home/home_page_below_conten.dart';
import 'package:flutter_shop/model/home/home_page_context.dart';
import '../service/service_method.dart';
import 'dart:convert';

import 'home/ad_banner.dart';
import 'home/floor_content.dart';
import 'home/floor_title.dart';
import 'home/leader_phone.dart';
import 'home/recommend_widget.dart';
import 'home/swiper_diy.dart';
import 'home/top_navigator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';
  int page = 1;
  List<HotGoods> hotGoodsList = [];

  @override
  void initState() {
    super.initState();
    _getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    var fromData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
        body: FutureBuilder(
      future: request('homePageContext', fromData: fromData),
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
          String floor1Title = homePageContextModel.floor1Pic.pICTUREADDRESS;
          List<Floor> floor1List = homePageContextModel.floor1;

          String floor2Title = homePageContextModel.floor2Pic.pICTUREADDRESS;
          List<Floor> floor2List = homePageContextModel.floor2;
          String floor3Title = homePageContextModel.floor3Pic.pICTUREADDRESS;
          List<Floor> floor3List = homePageContextModel.floor3;

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
                ),
                FloorTitle(
                  pictureAddress: floor1Title,
                ),
                FloorContent(
                  floorList: floor1List,
                ),
                FloorTitle(
                  pictureAddress: floor2Title,
                ),
                FloorContent(
                  floorList: floor2List,
                ),
                FloorTitle(
                  pictureAddress: floor3Title,
                ),
                FloorContent(
                  floorList: floor3List,
                ),
                _hotGoods(),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('加载中....'),
          );
        }
      },
    ));
  }

  void _getHotGoods() {
    var fromPage = {'page': page};
    request('homePageBelowConten', fromData: fromPage).then((value) {
      HomePageBelowContenModel homePageBelowContenModel =
          HomePageBelowContenModel.fromJson(json.decode(value));
      List<HotGoods> newGoodList = homePageBelowContenModel.data;

      setState(() {
        hotGoodsList.addAll(newGoodList);
        page++;
      });
    });
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(5),
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> hotListWidget = hotGoodsList.map((item) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(
                  item.image,
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${item.mallPrice}'),
                    Text(
                      '￥${item.price}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        children: hotListWidget,
        spacing: 2,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[hotTitle, _wrapList()],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
