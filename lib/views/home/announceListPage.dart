import 'package:cy_app/api/app.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnounceListPage extends StatefulWidget {
  @override
  _AnnounceListPageState createState() => _AnnounceListPageState();
}

class _AnnounceListPageState extends State<AnnounceListPage> with AutomaticKeepAliveClientMixin {
  List _announceList = [];
  int _page = 0;
  EasyRefreshController _controller;
  String _userRole;

  Widget _announceCard() {
    List<Widget> _announceListWidget = [];
    for (var a in _announceList) {
      _announceListWidget.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/announce', arguments: {"announce": a});
        },
        child: Card(
            color: Color.fromARGB(255, 36, 38, 49),
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0)),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    a["title"],
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    SdopDateUtils().tsToDate(a["ts"] * 1000000),
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            )),
      ));
    }
    return ListView(
      children: _announceListWidget,
    );
  }

  @override
  bool get wantKeepAlive => true;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString("user_role");
    });
    _getAnnounceList();
  }

  _getAnnounceList() async {
    var announce = await AppRequest.announcement(_userRole,_page, 10);
    if (announce.data["status"]["success"] == 1) {
      if (announce.data["result"]["data"].length == 0) {
        return false;
      }
      setState(() {
        _announceList.addAll(announce.data["result"]["data"]);
      });
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "公告",
        ),
        elevation: 1,
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
              _announceList.clear();
            });
            await _getUserInfo();
            _controller.resetLoadState();
          },
          onLoad: () async {
            setState(() {
              _page++;
            });
            var isMore = await _getAnnounceList();
            _controller.finishLoad(noMore: isMore);
          },
          child: _announceCard()),
    );
  }
}
