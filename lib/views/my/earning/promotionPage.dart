import 'package:cy_app/api/account.dart';
import 'package:cy_app/api/fund.dart';
import 'package:cy_app/components/earning/EarningCardWidget.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../../components/earning/EarningTableWidget.dart';
import '../../../components/earning/EarningCardWidget.dart';

class PromotionPage extends StatefulWidget {
  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  Map _promotionData;
  List _promotionEarningList = [];
  int _page = 0;

  bool get wantKeepAlive => true;

  EasyRefreshController _controller;

  _getPromotionEarningList() async {
    var result = await FundRequest.record(_page, 20, category: "REWARD_BUY", asset: "");
    if (result.data["status"]["success"] == 1) {
      if (result.data["result"]["data"].length == 0) {
        return false;
      }
      setState(() {
        _promotionEarningList.addAll(result.data["result"]["data"]);
      });
      return true;
    }
  }

  _getPromotionData() async {
    var result = await AccountRequest.reward_overview();
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _promotionData = result.data["result"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _getPromotionData();
    _getPromotionEarningList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: [
      Column(children: [
        Expanded(
            child: EasyRefresh(
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
                    _promotionEarningList.clear();
                  });
                  await _getPromotionEarningList();
                  _controller.resetLoadState();
                },
                onLoad: () async {
                  setState(() {
                    _page++;
                  });
                  var isMore = await _getPromotionEarningList();
                  _controller.finishLoad(noMore: isMore);
                },
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    earningTableWidget(_promotionEarningList),
                  ],
                ))),
      ]),
      Positioned(
          //C0CA33
          bottom: 10,
          left: 0,
          right: 0,
          child: Offstage(
            offstage: false,
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/invite');
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                  child: Text("邀请好友", style: TextStyle(color: Colors.black)),
                )),
          ))
    ]));
  }
}
