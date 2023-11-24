import 'package:carousel_slider/carousel_slider.dart';
import 'package:cy_app/api/account.dart';
import 'package:cy_app/api/app.dart';
import 'package:cy_app/api/product.dart';
import 'package:cy_app/components/ProductWidget.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:cy_app/views/mall/mainPage.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/AnnounceWidget.dart';
import '../../components/home/HomeEarningCardWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _innovationProductList = [];
  List _clusterProductList = [];
  List _mainProductList = [];
  List _announcement = [];

  List<Widget> _bannerList = [];

  String _userRole;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString("user_role");
    });
  }

  _getInnovationProductList() async {
    var result = await ProductRequest.hotProductList("INNOVATION");
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _innovationProductList = result.data["result"];
      });
    }
  }

  _getClusterProductList() async {
    var result = await ProductRequest.hotProductList("CLUSTER");
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _clusterProductList = result.data["result"];
      });
    }
  }

  _getMainProductList() async {
    var result = await ProductRequest.hotProductList("MAIN");
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _mainProductList = result.data["result"];
      });
    }
  }

  _getBannerList() async {
    var result = await AppRequest.banner();
    if (result.data["status"]["success"] == 1) {
      _bannerList.clear();
      for (var b in result.data["result"]) {
        _bannerList.add(Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            child: GestureDetector(
              child: Image.network(b["img_url"],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity),
              onTap: () {},
            )));
      }
    }
  }

  _getAnnounce() async {
    var result = await AppRequest.announcement(_userRole, 0, 10);
    if (result.data["status"]["success"] == 1) {
      _announcement.clear();
      setState(() {
        _announcement = result.data["result"]["data"];
      });
    }
  }

  void _initState() async {
    await _getUserInfo();
    _getInnovationProductList();
    _getMainProductList();
    _getBannerList();
    _getAnnounce();
    _getClusterProductList();
  }

  @override
  void initState() {
    super.initState();
    _initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  int _popCount = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
        child: RefreshIndicator(
            onRefresh: () async {
              await _getInnovationProductList();
              await _getMainProductList();
              await _getBannerList();
              await _getAnnounce();
              await _getUserInfo();
              await _getClusterProductList();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  color: Colors.yellow,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: CarouselSlider(
                    key: UniqueKey(),
                    items: _bannerList,
                    options: CarouselOptions(
                        height: 180, viewportFraction: 1.1, autoPlay: true),
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
                AnnounceWidget(announce: _announcement),
                Offstage(
                    offstage: _userRole == "CLUSTER" ? true : false,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _mainProductList.length == 0 ? "" : "主流区",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                Offstage(
                    offstage: _userRole == "CLUSTER" ? true : false,
                    child: ProductWidget(
                      productList: _mainProductList,
                    )),
                Offstage(
                    offstage: _userRole == "CLUSTER" ? true : false,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _innovationProductList.length == 0 ? "" : "创新区",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                Offstage(
                    offstage: _userRole == "CLUSTER" ? true : false,
                    child: ProductWidget(
                      productList: _innovationProductList,
                    )),
                Offstage(
                    offstage: _userRole == "MINER" ? true : false,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _clusterProductList.length == 0 ? "" : "集群",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                Offstage(
                  offstage: _userRole == "MINER" ? true : false,
                  child: ProductWidget(
                    productList: _clusterProductList,
                  ),
                )
              ],
            )),
        onWillPop: () async {
          if (_popCount < 1) {
            Toast.success("再来一次退出");
            setState(() {
              _popCount++;
            });
            return Future.value(false);
          } else {
            return true;
          }
        });
  }
}
