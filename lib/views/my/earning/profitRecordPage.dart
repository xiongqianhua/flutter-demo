import 'package:cy_app/api/fund.dart';
import 'package:cy_app/utils/CategoryUtil.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ProfitRecordPage extends StatefulWidget {
  @override
  _ProfitRecordPageState createState() => _ProfitRecordPageState();
}

class _ProfitRecordPageState extends State<ProfitRecordPage> with AutomaticKeepAliveClientMixin {
  List _profitRecordList = [];
  int _page = 0;
  EasyRefreshController _controller;
  String _category = "全部类型";
  String _asset = "全部币种";
  List assetOption = [];
  List catetoryOption = ["全部类型", "充值", "质押", "提币", "产品购买", "分红", "25%收益", "75%收益"];

  @override
  bool get wantKeepAlive => true;

  _getAssetList() async {
    var result = await FundRequest.assetList();
    if (result.data["status"]["success"] == 1) {
      setState(() {
        assetOption = result.data["result"].map((item) {
          return item["asset"];
        }).toList();
        assetOption.insert(0,"全部币种");
      });
      return true;
    }
  }

  _getRecordList() async {
    var result = await FundRequest.record(_page, 25,
        category: SdopCategoryUtils().reverseConvert(_category), asset: _asset == "全部币种" ? "" : _asset);
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
    _getAssetList();
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
        child: Text('类型'),
      ),
      Text('数量'),
      Text("资产"),
      Text('时间'),
      // Text('状态'),
    ]));
    for (var item in _profitRecordList) {
      _rows.add(TableRow(children: [
        SizedBox(height: 30, child: Text(SdopCategoryUtils().Convert(item["category"]))),
        Text(item["amount"].toString()),
        Text(item["asset"]),
        Text(SdopDateUtils().tsToDate(item["ts"] * 1000000)),
        // Text(item["state"]),
      ]));
    }
    return ListView(children: <Widget>[
      Container(
          padding: EdgeInsets.all(15),
          child: Table(columnWidths: const {
            0: FixedColumnWidth(90.0),
            1: FixedColumnWidth(100.0),
            2: FixedColumnWidth(45.0),
            3: FixedColumnWidth(130.0),
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
          title: Text('资金记录'),
          centerTitle: true,
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: DropdownButton(
                  value: _category,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.lime),
                  underline: Container(
                    height: 2,
                    color: Colors.lime,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _page = 0;
                      _profitRecordList.clear();
                      _category = newValue;
                    });
                    _getRecordList();
                  },
                  items: catetoryOption.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: DropdownButton(
                  value: _asset,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.lime),
                  underline: Container(
                    height: 2,
                    color: Colors.lime,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _page = 0;
                      _profitRecordList.clear();
                      _asset = newValue;
                    });
                    _getRecordList();
                  },
                  items: assetOption.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
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
