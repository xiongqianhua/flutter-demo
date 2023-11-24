import 'package:cy_app/api/account.dart';
import 'package:cy_app/api/fund.dart';
import 'package:cy_app/components/recordDepositTableWidget.dart';
import 'package:cy_app/components/setting/SettingCardWidget.dart';
import 'package:cy_app/utils/MathUtil.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/Toast.dart';

class RecordDepositPage extends StatefulWidget {
  @override
  _RecordDepositPageState createState() => _RecordDepositPageState();
}

class _RecordDepositPageState extends State<RecordDepositPage> with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _recordRefreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List _recordList = [];
  String _asset;
  int _page = 0;
  EasyRefreshController _controller;

  // dynamic _args;

  @override
  bool get wantKeepAlive => true;

  _getRecordList() async {
    var result = await FundRequest.record( _page, 10,category:"DEPOSIT",asset: _asset);
    if (result.data["status"]["success"] == 1) {
      if (result.data["result"]["data"].length == 0) {
        return false;
      }
      setState(() {
        _recordList.addAll(result.data["result"]["data"]);
      });
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dynamic _args = ModalRoute.of(context).settings.arguments;
      setState(() {
        _asset = _args["asset"];
      });
      _getRecordList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "充币记录",
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
                _recordList.clear();
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
            child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  recordDepositTableWidget(_recordList),
                  Offstage(
                    offstage: _recordList.length == 0 ? false : true,
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "没有更多数据",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ])));
  }
}
