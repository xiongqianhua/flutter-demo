import 'package:cy_app/api/account.dart';
import 'package:cy_app/components/NumChangeWidget.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:cy_app/components/countDownWidget.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';

class ProductWidget extends StatefulWidget {
  final List productList;

  ProductWidget({Key key, this.productList}) : super(key: key);

  @override
  _ProductWidgetState createState() {
    return _ProductWidgetState();
  }
}

class _ProductWidgetState extends State<ProductWidget>
    with AutomaticKeepAliveClientMixin {
  Map<String, int> _amount = Map();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _tagsWidget(int isU) {
    List tags = [];
    List<Widget> _tags = [];
    for (var item in tags) {
      _tags.add(new TextTagWidget(
        item,
        padding: EdgeInsets.all(2.0),
        textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300),
        backgroundColor: Colors.lime.withOpacity(0.5),
      ));
    }
    return Row(
      children: _tags,
    );
  }

  int _seconds(int ts, int es) {
    if (ts < SdopDateUtils.nowTimestamp()) {
      if (es < SdopDateUtils.nowTimestamp()) {
        return 0;
      }
      return es - SdopDateUtils.nowTimestamp();
    }
    return ts - SdopDateUtils.nowTimestamp();
  }

  @override
  Widget build(BuildContext context) {
    return widget.productList == null
        ? Container()
        : Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.productList.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Color.fromARGB(255, 38, 40, 54),
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0)),
                  ),
                  child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.productList[index]["title"],
                                    style: TextStyle(
                                        fontSize: 16.0, fontWeight: FontWeight
                                        .w400),
                                  ),
                                  _tagsWidget(widget
                                      .productList[index]["usdt_reward_state"]),
                                ]),
                            Container(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("挖矿币种: ${widget
                                    .productList[index]["asset"]}"),
                                Text(
                                    "每T所需: ${widget
                                        .productList[index]["total_staking_per_1t"]} ${widget
                                        .productList[index]["asset"]}")
                              ],
                            ),
                            Container(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget
                                    .productList[index]["duration_days"] == 0
                                    ? "合约期限: 永久"
                                    : "合约期限: ${widget
                                    .productList[index]["duration_days"]}天"),
                                Text("技术服务费: ${widget
                                    .productList[index]["service_fee"] * 100}%")
                              ],
                            ),
                            Container(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${widget
                                            .productList[index]["price"]}",
                                        style: TextStyle(fontSize: 18.0,
                                            color: Colors.lime,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        " USDT",
                                        style: TextStyle(fontSize: 14.0,
                                            color: Colors.lime,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]),
                                Row(children: [
                                  Text("每份${widget.productList[index]["fen"]
                                      .toString()}T "),
                                  NumChangeWidget(
                                    num: _amount["$index"] ?? 0,
                                    onValueChanged: (int value) {
                                      setState(() {
                                        _amount["$index"] = value;
                                      });
                                    },
                                  ),
                                  Text(" 份")
                                ])
                              ],
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.centerLeft,
                              children: <Widget>[
                                Positioned(
                                  child: Container(
                                      height: 10.0,
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                          top: 20.0, bottom: 20.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey.withOpacity(
                                              0.3),
                                          borderRadius: BorderRadius.circular(
                                              5.0)),
                                      child: Offstage()),
                                ),
                                Positioned(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: (NumUtil.divideDecStr(
                                          widget.productList[index]["sold_fen"]
                                              .toString(),
                                          widget.productList[index]["amount"]
                                              .toString())
                                          .toDouble()) >
                                          0.14
                                          ? MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          (NumUtil.divideDecStr(widget
                                              .productList[index]["sold_fen"]
                                              .toString(),
                                              widget
                                                  .productList[index]["amount"]
                                                  .toString()))
                                              .toDouble()
                                          : MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.2,
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      decoration:
                                      BoxDecoration(color: Colors.lime,
                                          borderRadius: BorderRadius.circular(
                                              10.0)),
                                      height: 15.0,
                                      child: Text(
                                        "${NumUtil.multiplyDecStr(widget
                                            .productList[index]["sold_fen"]
                                            .toString(),
                                            widget.productList[index]["fen"]
                                                .toString())}T/${NumUtil
                                            .multiplyDecStr(
                                            widget.productList[index]["amount"]
                                                .toString(),
                                            widget.productList[index]["fen"]
                                                .toString())}T",
                                        style: TextStyle(color: Colors.white,
                                            fontSize: 12.0),
                                      ),
                                    ))
                              ],
                            ),
                            Offstage(
                                offstage: widget.productList[index]["state"] ==
                                    "ON" ? false : true,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        (NumUtil.subtractDecStr(widget
                                            .productList[index]["start_ts"]
                                            .toString(),
                                            SdopDateUtils.nowTimestamp()
                                                .toString()))
                                            .toInt() <=
                                            0
                                            ? "抢购倒计时"
                                            : "距开始抢购",
                                        style: TextStyle(color: Colors.lime),
                                      ),
                                      CountDownWidget(
                                          seconds: _seconds(
                                              NumUtil.getIntByValueStr(
                                                  widget
                                                      .productList[index]["start_ts"]
                                                      .toString()),
                                              NumUtil.getIntByValueStr(
                                                  widget
                                                      .productList[index]["expiration_ts"]
                                                      .toString()))),
                                    ],
                                  ),
                                )),
                            TextButton(
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        Size(double.infinity, 40)),
                                    backgroundColor: MaterialStateProperty.all(
                                        (NumUtil.divideDecStr(
                                            widget.productList[index]["sold_fen"]
                                                .toString(),
                                            widget.productList[index]["amount"]
                                                .toString()))
                                            .toDouble() ==
                                            1
                                            ?Colors.grey:Colors.yellow),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(10.0))),
                                child: Text(
                                  _seconds(
                                      NumUtil.getIntByValueStr(
                                          widget.productList[index]["start_ts"]
                                              .toString()),
                                      NumUtil.getIntByValueStr(
                                          widget
                                              .productList[index]["expiration_ts"]
                                              .toString())) ==
                                      0
                                      ? "活动已结束"
                                      : ((NumUtil.divideDecStr(
                                      widget.productList[index]["sold_fen"]
                                          .toString(),
                                      widget.productList[index]["amount"]
                                          .toString()))
                                      .toDouble() ==
                                      1
                                      ? "已售罄"
                                      : "立即购买"),
                                  style: TextStyle(fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                onPressed: (_seconds(
                                    NumUtil.getIntByValueStr(
                                        widget.productList[index]["start_ts"]
                                            .toString()),
                                    NumUtil.getIntByValueStr(
                                        widget
                                            .productList[index]["expiration_ts"]
                                            .toString())) ==
                                    0 ||
                                    (NumUtil.divideDecStr(widget
                                        .productList[index]["sold_fen"]
                                        .toString(),
                                        widget.productList[index]["amount"]
                                            .toString()))
                                        .toDouble() ==
                                        1)
                                    ? null
                                    : (_amount["$index"] == 0 ||
                                    _amount["$index"] == null
                                    ? () {
                                  Toast.warm("请输入要购买的数量");
                                }
                                    : () {
                                  if (_amount["$index"] >
                                      NumUtil.subtractDecStr(
                                          widget.productList[index]["amount"]
                                              .toString(),
                                          widget.productList[index]["sold_fen"]
                                              .toString())
                                          .toDouble()) {
                                    Toast.warm(
                                        "库存不足,最大可购买${NumUtil.getNumByValueStr(
                                            (widget
                                                .productList[index]["amount"] -
                                                widget
                                                    .productList[index]["sold_fen"])
                                                .toString(),
                                            fractionDigits: 0)}份");
                                    return false;
                                  }
                                  Navigator.of(context).pushNamed(
                                      "/order", arguments: {
                                    "productId": widget
                                        .productList[index]["id"],
                                    "per": widget.productList[index]['fen'],
                                    "amount": _amount["$index"]
                                  });
                                }))
                          ])));
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
