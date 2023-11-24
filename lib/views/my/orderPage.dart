import 'package:cy_app/api/product.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  List productivityListData;
  int _page = 0;
  EasyRefreshController _controller;
  List _orderList = [];
  dynamic _staking_amount = 0;
  int _order_id;

  _order() async {
    var result = await ProductRequest.productOrder(_page, 10);
    if (result.data["status"]["success"] == 1) {
      if (result.data["result"]["data"].length == 0) {
        return false;
      }
      setState(() {
        _orderList.addAll(result.data["result"]["data"]);
      });
      return true;
    }
  }

  _staking() async {
    var result = await ProductRequest.staking({"amount": _staking_amount, "order_id": _order_id});
    if (result.data["status"]["success"] == 1) {
      Toast.success("质押成功");
      Navigator.of(context).pop();
    }
  }

  Widget _orderWidget() {
    List<Widget> _orderListWidget = [];
    if (_orderList == null || _orderList.length == 0) {
      _orderListWidget.add(Container(
        alignment: Alignment.center,
        child: Text("暂无更多数据"),
      ));
      return ListView(
        children: _orderListWidget,
      );
    }
    for (var o in _orderList) {
      _orderListWidget.add(Card(
          color: Color.fromARGB(255, 36, 38, 49),
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0)),
          ),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(15),
                  child: Text(o["duration_days"] == 0 ? "${o["title"]}(永久)" : "${o["title"]}(${o["duration_days"]}天)"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/my/asset/staked', arguments: {"order_id": o["order_id"]});
                    },
                    child: Text(
                      "质押订单",
                      style: TextStyle(fontSize: 12, color: Colors.lime),
                    ))
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("价格: ${o["price"]}USDT"),
                  Text("数量: ${NumUtil.multiplyDecStr(o["fen_bought"].toString(), o["fen"].toString()).toString()}T"),
                  Text("已质押: ${o["staked_amount"]}T")
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("每T所需: ${o["total_staking_per_1t"]}${o["asset"]}"),
                  Text("购买日期: ${SdopDateUtils().tsToDate(o["ts"] * 1000000, pattern: SdopDateUtils.DATE_TIME_PATTERN)}")
                ],
              ),
            ),
            Container(
              child: TextButton(
                onPressed: NumUtil.multiplyDecStr(o["fen_bought"].toString(), o["fen"].toString()).toDouble() ==
                        o["staked_amount"]
                    ? null
                    : () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: Text("请输入质押数量"),
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.lock),
                                      hintText: '请输入质押数量',
                                      labelText: '质押数量',
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        _order_id = o["order_id"];
                                        _staking_amount = value;
                                      });
                                    },
                                    validator: (String value) {
                                      if (value.isEmpty || value == null) {
                                        return "数量不能为空";
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SimpleDialogOption(
                                        onPressed: () {
                                          _staking();
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Text("确认"),
                                      ),
                                      SimpleDialogOption(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("取消"),
                                      )
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                child: Text(NumUtil.multiplyDecStr(o["fen_bought"].toString(), o["fen"].toString()).toDouble() ==
                        o["staked_amount"]
                    ? "已 质 押"
                    : "质  押",style: TextStyle(color: Colors.black),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        NumUtil.multiplyDecStr(o["fen_bought"].toString(), o["fen"].toString()).toDouble() ==
                                o["staked_amount"]
                            ? Colors.white10
                            : Colors.lime)),
              ),
              width: double.infinity,
            )
          ])));
    }
    return ListView(
      children: _orderListWidget,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _order();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "我的订单",
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
              _orderList.clear();
            });
            await _order();
            _controller.resetLoadState();
          },
          onLoad: () async {
            setState(() {
              _page++;
            });
            var isMore = await _order();
            _controller.finishLoad(noMore: isMore);
          },
          child: _orderWidget()),
    );
  }
}
