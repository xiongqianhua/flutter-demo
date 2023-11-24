import 'package:cy_app/api/fund.dart';
import 'package:cy_app/utils/CategoryUtil.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class StakingRecordPage extends StatefulWidget {
  @override
  _StakingRecordPageState createState() => _StakingRecordPageState();
}

class _StakingRecordPageState extends State<StakingRecordPage> with AutomaticKeepAliveClientMixin {
  List _stakingRecordList = [];
  int _page = 0;
  EasyRefreshController _controller;

  @override
  bool get wantKeepAlive => true;

  _getRecordList() async {
    var result = await FundRequest.record( _page, 25,category:"STAKING",asset: "");
    if (result.data["status"]["success"] == 1) {
      if (result.data["result"]["data"].length == 0) {
        return false;
      }
      setState(() {
        _stakingRecordList.addAll(result.data["result"]["data"]);
      });
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _getRecordList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _recordListWidget() {
    List<TableRow> _rows = [];
    _rows.add(TableRow(children: [
      SizedBox(
        height: 30,
        child: Text("数量"),
      ),
      Text('资产'),
      Text("类型"),
      Text('时间'),
      // Text('状态'),
    ]));
    for (var item in _stakingRecordList) {
      _rows.add(TableRow(children: [
        SizedBox(height: 30, child: Text(item["amount"].toString())),
        Text(item["asset"].toString()),
        Text(SdopCategoryUtils().Convert(item["category"].toString())),
        Text(SdopDateUtils().tsToDate(item["ts"] * 1000000)),
        // Text(item["state"]),
      ]));
    }
    return ListView(children: <Widget>[
      Container(
          padding: EdgeInsets.all(15),
          child: Table(columnWidths: const {
            0: FixedColumnWidth(100.0),
            1: FixedColumnWidth(50.0),
            2: FixedColumnWidth(60.0),
            3: FixedColumnWidth(150.0),
          }, children: _rows)),
      Offstage(
        offstage: _stakingRecordList.length == 0 ? false : true,
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "没有更多数据",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('资金记录'),
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
                _stakingRecordList.clear();
              });
              await _getRecordList();
              _controller.resetLoadState();
            },
            onLoad: () async {
              setState(() {
                _page++;
              });
              var isMore = await _getRecordList();
              _controller.finishLoad(noMore: isMore);
            },
            child: _recordListWidget()));
  }
}
