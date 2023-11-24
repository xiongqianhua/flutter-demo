import 'package:cy_app/api/product.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class ArticalWidget extends StatefulWidget {
  // final initPage;
  //
  // ArticalWidget({Key key, this.initPage}) : super(key: key);

  @override
  _ArticalWidgetState createState() {
    return _ArticalWidgetState();
  }
}

class _ArticalWidgetState extends State<ArticalWidget> with TickerProviderStateMixin {
  List productivityListData;
  TabController _tabController;
  int _amount;
  bool _isChecked = false;
  bool _isNotValidate = true;

  dynamic _pdData = {};
  int _pid;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dynamic _args = ModalRoute.of(context).settings.arguments;
      setState(() {
        _amount = NumUtil.getIntByValueStr(_args["amount"].toString());
        _pid = _args["productId"];
      });
      _getProductDetail();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getProductDetail() async {
    var pd = await ProductRequest.productDetail(_pid);
    if (pd.data["status"]["success"] == 1) {
      setState(() {
        _pdData = pd.data["result"];
      });
    }
  }

  _buy() async {
    var result = await ProductRequest.productBuy({"id": _pid, "amount": _amount});
    if (result.data["status"]["success"] == 1) {
      Toast.success("购买成功");
      // setState(() {
      //   _pdData = result.data["result"];
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.context;
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text("确认订单"),
            centerTitle: true,
          ),
          body: Container(
              child: ListView(
            children: <Widget>[
              Card(
                color: Color.fromARGB(255, 36, 38, 49),
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0)),
                ),
                child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "确认订单",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          child: Divider(
                            height: 2,
                          ),
                          padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 70.0,
                                  child: Text("合 约 名  称"),
                                ),
                                Text(_pdData["title"])
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 70.0,
                                  child: Text("合 约 期  限"),
                                ),
                                Text("${_pdData["duration_days"]}天(整个周期${_pdData["duration_days"]}天)")
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 70.0,
                                  child: Text("技术服务费"),
                                ),
                                Text("20%(从挖矿收益中直接扣除)")
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 70.0,
                                  child: Text(
                                    "单            价",
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Row(children: [Text("\$${_pdData["price"]}/TB")])
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 70.0,
                                  child: Text("购 买 数  量"),
                                ),
                                Row(children: [Text("${_amount} TB")])
                              ],
                            )),
                        Container(
                          child: Divider(
                            height: 2,
                          ),
                          padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 70.0,
                                  child: Text("总计金额"),
                                ),
                                Row(children: [
                                  Text(
                                    "${_pdData["price"] * _amount} USDT",
                                    style: TextStyle(fontSize: 18.0, color: Colors.lime, fontWeight: FontWeight.w600),
                                  )
                                ])
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Icon(
                                        _isChecked ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                        size: 16.0,
                                        color: _isChecked ? Colors.lime : null,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _isChecked = !_isChecked;
                                          _isNotValidate = _isChecked;
                                        });
                                      },
                                    ),
                                    Text("  我已经阅读并同意《用户算力租赁协议》"),
                                  ],
                                ),
                                Offstage(
                                  child: Text(
                                    "      请先阅读用户协议",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  offstage: _isNotValidate,
                                )
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20.0),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              if (!_isChecked) {
                                setState(() {
                                  _isNotValidate = false;
                                });
                              } else {
                                _buy();
                              }
                            },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                            child: Text(
                              "立即购买",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ))),
    );
  }
}
