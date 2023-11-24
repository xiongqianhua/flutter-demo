import 'package:cy_app/api/app.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<DiscoveryPage> {
  List _news = [];
  int _page = 0;
  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _getNews();
  }

  _getNews() async {
    var result = await AppRequest.news(_page, 10);
    if (result.data["status"]["success"] == 1) {
      if (result.data["result"].length == 0) {
        return false;
      }
      setState(() {
        _news.addAll(result.data["result"]["data"]);
      });
      return true;
    }
  }

  Widget _newsWidget() {
    List<Widget> _newsWidgetList = [];

    for (var n in _news) {
      _newsWidgetList.add(
        GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(n["title"] ?? ""),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(n["img"]))),
                // child: Image.network(n["img"]),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  " ${SdopDateUtils().tsToDate(n["ts"] * 1000000)}",
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Divider(
                  height: 2,
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.of(context).pushNamed("/news", arguments: {"news_id": n["id"]});
          },
        ),
      );
    }
    return ListView(
      children: _newsWidgetList,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _popCount = 0;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Container(alignment: Alignment.center, child: Text('发现')),
            ),
            body: EasyRefresh(
                controller: _controller,
                enableControlFinishLoad: true,
                enableControlFinishRefresh: false,
                header: ClassicalHeader(
                    textColor: Colors.white,
                    refreshedText: "刷新完成",
                    refreshFailedText: "刷新失败",
                    refreshingText: "正在刷新",
                    refreshReadyText: "准备刷新",
                    refreshText: "刷新"),
                footer: ClassicalFooter(
                    textColor: Colors.white,
                    loadedText: "加载完成",
                    loadFailedText: "加载失败",
                    loadingText: "加载中",
                    loadReadyText: "准备加载",
                    loadText: "加载",
                    noMoreText: "没有更多数据"),
                onRefresh: () async {
                  setState(() {
                    _page = 0;
                    _news.clear();
                  });
                  await _getNews();
                  _controller.resetLoadState();
                },
                onLoad: () async {
                  setState(() {
                    _page++;
                  });
                  var isMore = await _getNews();
                  _controller.finishLoad(noMore: isMore);
                },
                child: _newsWidget())),
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
    ;
  }
}
