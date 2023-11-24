import 'package:cy_app/api/fund.dart';
import 'package:cy_app/utils/CategoryUtil.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class GroupRecordPage extends StatefulWidget {
  final category;

  GroupRecordPage({Key key, this.category}) : super(key: key);

  @override
  _GroupRecordPageState createState() => _GroupRecordPageState();
}

class _GroupRecordPageState extends State<GroupRecordPage> with AutomaticKeepAliveClientMixin {
  List _profitRecordList = [];
  int _page = 0;
  EasyRefreshController _controller;

  @override
  bool get wantKeepAlive => true;

  _getRecordList() async {
    var result = await FundRequest.groupRecordList(_page, 25, category: widget.category == 1 ? 'CLUSTER':'MINER');
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _profitRecordList.addAll(result.data["result"]["data"]);
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
        child:Text('手机号'),
      ),

      Text('数量'),
      Text("资产"),
      Text("社区容量"),
      Text("有效容量"),
      // Text('状态'),
    ]));
    for (var item in _profitRecordList) {
      _rows.add(TableRow(children: [
        // SizedBox(height: 30, child: Text(item["user_id"].toString())),
        Text(item["phone"].toString()),
        Text(item["amount"].toString()),
        Text(item["asset"]),
        Text(item["community_bought_cap"].toString()),
        Text(item["community_valid_cap"].toString()),
      ]));
    }
    return ListView(children: <Widget>[
      Container(
          padding: EdgeInsets.all(10),
          child: Table(columnWidths: const {
            0: FixedColumnWidth(60.0),
            1: FixedColumnWidth(10.0),
            // 2: FixedColumnWidth(90.0),
            2: FixedColumnWidth(10.0),
            3: FixedColumnWidth(15.0),
            4: FixedColumnWidth(30.0),
            // 5: FixedColumnWidth(30.0),
          }, children: _rows)),
      Offstage(
        offstage: _profitRecordList.length == 0 ? false : true,
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
          title: Text('团队收益'),
          centerTitle: true,
        ),
        body: Column(children: [
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
                      _profitRecordList.clear();
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
                  child: _recordListWidget()))
        ]));
  }
}
