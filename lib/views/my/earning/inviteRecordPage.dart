import 'package:cy_app/api/account.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class InviteRecordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InviteRecordPageState();
  }
}

class _InviteRecordPageState extends State<InviteRecordPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List _inviteList = [];
  int _page = 0;
  EasyRefreshController _controller;

  _getInviteList() async {
    var result = await AccountRequest.invitation(_page, 10);
    if (result.data["status"]["success"] == 1) {
      if (result.data["result"].length == 0) {
        return false;
      }
      setState(() {
        _inviteList.addAll(result.data["result"]);
      });
      return true;
    }
  }

  Widget _invite() {
    List<Widget> inviteWidget = [];
    inviteWidget.add(Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text("手机号"), Text("时间")],
      ),
    ));
    for (var i in _inviteList) {
      inviteWidget.add(Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(i["phone"]),
            Text(SdopDateUtils().tsToDate(i["ts"] * 1000000))
          ],
        ),
      ));
    }
    return ListView(
      children: inviteWidget,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _getInviteList();
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
          title: Text('邀请记录'),
          centerTitle: true,
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
                _inviteList.clear();
              });
              await _getInviteList();
              _controller.resetLoadState();
            },
            onLoad: () async {
              setState(() {
                _page++;
              });
              var isMore = await _getInviteList();
              _controller.finishLoad(noMore: isMore);
            },
            child: _invite()));
  }
}
