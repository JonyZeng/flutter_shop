import 'package:flutter/material.dart';
import 'package:flutter_shop/model/home/home_page_context.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              HomePageContextModel homePageContextModel =HomePageContextModel.fromJson(data['data']);
              List<Slides> slides = homePageContextModel.slides;
              return Column(
                children: <Widget>[
                  SwiperDiy(
                    swiperDateList: slides,
                  )
                ],
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
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List<Slides> swiperDateList;

  const SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(swiperDateList.toString());
    return Container(
      height: 333,
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
