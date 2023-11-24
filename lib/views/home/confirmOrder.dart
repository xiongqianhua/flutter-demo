import 'package:cy_app/api/account.dart';
import 'package:cy_app/api/product.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrderPage extends StatefulWidget {
  @override
  _ConfirmOrderPageState createState() {
    return _ConfirmOrderPageState();
  }
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage>
    with AutomaticKeepAliveClientMixin {
  List productivityListData;
  String _amount;
  String _per;
  bool _isChecked = false;
  bool _isNotValidate = true;
  String _fund_password = "";
  dynamic _levelConfig;
  dynamic _pdData;
  int _pid;

  _getLevelConfig(asset) async {
    var pd = await AccountRequest.levelConfig(asset);
    if (pd.data["status"]["success"] == 1) {
      setState(() {
        _levelConfig = pd.data["result"];
      });
    }
  }

  _getProductDetail(pid) async {
    var pd = await ProductRequest.productDetail(pid);
    if (pd.data["status"]["success"] == 1) {
      setState(() {
        _pdData = pd.data["result"];
      });
      _getLevelConfig(_pdData["asset"]);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dynamic _args = ModalRoute.of(context).settings.arguments;
      setState(() {
        _amount = _args["amount"].toString();
        _pid = _args["productId"];
        _per = _args["fen"].toString();
      });
      _getProductDetail(_args["productId"]);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buy() async {
    var result = await ProductRequest.productBuy({
      "id": _pid,
      "amount": _amount,
      "fund_passwd": EncryptUtil.encodeMd5(_fund_password)
    });
    if (result.data["status"]["success"] == 1) {
      Toast.success("购买成功");
      Navigator.of(context).pop();
    }
  }

  Future<bool> _getfundPasswd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool("fund_passwd"));
    return prefs.getBool("fund_passwd");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
                              Text(_pdData == null ? "-" : _pdData["title"])
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
                              Text(_pdData == null
                                  ? "0"
                                  : (_pdData["duration_days"] == 0
                                      ? "永久"
                                      : "${_pdData["duration_days"]}天(整个周期${_pdData["duration_days"]}天)"))
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
                              Text(
                                  "${_pdData == null ? 0 : _pdData["service_fee"] * 100}%(从挖矿收益中直接扣除)")
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
                              Row(children: [
                                Text(
                                    "\$${_pdData == null ? "0" : _pdData["price"]}/TB")
                              ])
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
                              //
                              Row(children: [
                                Text(
                                    "${_amount}份(共计:${NumUtil.multiplyDecStr(_amount.toString(), _pdData["fen"].toString())} TB)")
                              ])
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 70.0,
                                    child: Text("总计金额"),
                                  ),
                                  Row(children: [
                                    Text(
                                      "原价:${NumUtil.multiplyDecStr(NumUtil.multiplyDecStr(_pdData["price"].toString(), _amount.toString()).toString(), _pdData["fen"].toString())} USDT",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          // color: Colors.lime,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.lime,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ])
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 15.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Row(children: [
                                    Text("折后价:"),
                                    Text(
                                      "${NumUtil.multiplyDecStr(_levelConfig["usdt_discount"].toString(), NumUtil.multiplyDecStr(NumUtil.multiplyDecStr(_pdData["price"].toString(), _amount.toString()).toString(), _pdData["fen"].toString()).toString())} USDT",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.lime,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ])
                                ],
                              )
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
                                      _isChecked
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      size: 22.0,
                                      color: _isChecked ? Colors.lime : null,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _isChecked = !_isChecked;
                                        _isNotValidate = _isChecked;
                                      });
                                    },
                                  ),
                                  Text("  我已经阅读并同意"),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed("/agreement");
                                    },
                                    child: Text(
                                      "《用户算力租赁协议》",
                                      style: TextStyle(color: Colors.lime),
                                    ),
                                  )
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
                          onPressed: NumUtil.getIntByValueStr(_amount) > 0
                              ? () async {
                                  if (!_isChecked) {
                                    setState(() {
                                      _isNotValidate = false;
                                    });
                                  } else {
                                    bool abc = await _getfundPasswd();
                                    if (abc) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              title: Text("请输入资金密码"),
                                              children: [
                                                TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(Icons.lock),
                                                    hintText: '请输入资金密码',
                                                    labelText: '资金密码',
                                                  ),
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      _fund_password = value;
                                                    });
                                                  },
                                                  obscureText: true,
                                                  validator: (String value) {
                                                    if (value.isEmpty ||
                                                        value == null) {
                                                      return "资金密码不能为空";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        _buy();
                                                        Navigator.of(context)
                                                            .pop(context);
                                                      },
                                                      child: Text("确认"),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("取消"),
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 10),
                                                          child: Text(
                                                              "未设置资金密码，前去设置?")),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SimpleDialogOption(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .popAndPushNamed(
                                                                        "/fund/password");
                                                              },
                                                              child:
                                                                  Text("设置")),
                                                          SimpleDialogOption(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(
                                                                        context);
                                                              },
                                                              child: Text("取消"))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  }
                                }
                              : null,
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.lime),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(color: Colors.white))),
                          child: Text("立即购买",style: TextStyle(color: Colors.black),),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        )));
  }
}
