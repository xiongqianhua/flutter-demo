import 'dart:async';
import 'package:cy_app/api/account.dart';
import 'package:cy_app/api/fund.dart';
import 'package:cy_app/views/my/addressPage.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/Toast.dart';

class InnerTransferPage extends StatefulWidget {
  final balance;
  final asset;

  const InnerTransferPage({Key key, this.balance = "0", this.asset})
      : super(key: key);

  @override
  _InnerTransferPageState createState() => _InnerTransferPageState();
}

class _InnerTransferPageState extends State<InnerTransferPage> {
  _navigateToAddress(BuildContext context) async {
    _recevPhonoe = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddressPage(isNotWithdraw: false)));
    setState(() {
      _recevPhonoeEditingController = TextEditingController.fromValue(
          TextEditingValue(text: _recevPhonoe ?? ""));
    });
  }

  TextEditingController _amountEditingController;
  TextEditingController _recevPhonoeEditingController;

  String _amount;
  String _realAmount = "0";
  String _recevPhonoe;
  Timer _timer;
  String _fund_password = "";
  String _validateCode = "";
  Map _config;

  _withdraw() async {
    var result = await FundRequest.transfer({
      "asset": widget.asset,
      "amount": _amount,
      "receiver_phone ": _recevPhonoe,
      "fund_passwd": EncryptUtil.encodeMd5(_fund_password),
      "code": _validateCode
    });
    if (result.data["status"]["success"] == 1) {
      Toast.success("提币请求已提交");
    }
  }

  _getConfig() async {
    var result = await FundRequest.config(widget.asset);
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _config = result.data["result"];
      });
    }
  }

  //倒计时数值
  var _countdownTime = 0;

  _getValidateCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var result = await AccountRequest.validateLoginCode(
        {"phone": prefs.getString("phone"), "business": "WITHDRAWAL"});
    print(result);
  }

  _btnPress() {
    if (_countdownTime == 0) {
      _getValidateCode();
      return startCountdown();
    }
  }

  String handleCodeAutoSizeText() {
    if (_countdownTime > 0) {
      return '$_countdownTime' + 's后重新发送';
    } else
      return '获取验证码';
  }

  call(timer) {
    if (_countdownTime < 1) {
      _timer.cancel();
      _timer = null;
    } else {
      setState(() {
        _countdownTime -= 1;
      });
    }
    print(_countdownTime);
  }

//倒计时方法
  startCountdown() {
    _countdownTime = 60;
    print({_countdownTime: _countdownTime, _timer: _timer == null});
    print(_timer);
    if (_timer == null) {
      print("开启定时器");
      _timer = Timer.periodic(Duration(seconds: 1), call);
    }
  }

  @override
  void initState() {
    super.initState();
    _getConfig();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 60.0,
                        child: Text("币种"),
                      ),
                      TextTagWidget(
                        widget.asset,
                        borderRadius: 5,
                        backgroundColor: Colors.lime,
                      ),
                    ],
                  ),
                ],
              )),
        ),
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
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 60.0,
                        child: Text("数量"),
                      ),
                      Text("可用: ${widget.balance ?? 0} ${widget.asset}")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: TextField(
                            controller: _amountEditingController,
                            onChanged: (value) {
                              setState(() {
                                _amount = value;
                                _realAmount = NumUtil.subtract(
                                        NumUtil.getDoubleByValueStr(
                                            _amount.toString()),
                                        _config == null ? 0 : _config["fee"])
                                    .toString();
                              });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "最小提币数量${_config == null ? "0" : _config["fee"]}",
                                hintStyle: TextStyle(fontSize: 14.0))),
                      ),
                      Row(
                        children: <Widget>[
                          Text("${widget.asset} | "),
                          GestureDetector(
                            child: Text("全部",
                                style: TextStyle(color: Colors.lime)),
                            onTap: () {
                              setState(() {
                                _realAmount = NumUtil.subtract(
                                        NumUtil.getDoubleByValueStr(
                                            widget.balance),
                                        _config == null ? 0 : _config["fee"])
                                    .toString();
                                _amountEditingController =
                                    TextEditingController.fromValue(
                                        TextEditingValue(text: widget.balance));
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("提币手续费"),
                    ],
                  ),
                  Container(
                      height: 45.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_config == null
                              ? "0"
                              : _config["fee"].toString()),
                          Text(widget.asset)
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("接收手机号"),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _recevPhonoe = value;
                                });
                              },
                              controller: _recevPhonoeEditingController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "输入或长按粘贴",
                                  hintStyle: TextStyle(fontSize: 14.0))),
                        ),
                      ])
                ],
              )),
        ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("实际到账数量"),
                Text(
                    "${NumUtil.getNumByValueStr(_realAmount) < 0 ? 0 : _realAmount} ${widget.asset}")
              ],
            ),
          ),
        ),
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
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: TextFormField(
                        onChanged: (String value) {
                          setState(() {
                            _validateCode = value;
                          });
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "输入短信验证码",
                            hintStyle: TextStyle(fontSize: 14.0))),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                        child: Text(handleCodeAutoSizeText(),
                            style: TextStyle(
                                color: _countdownTime == 0
                                    ? Colors.lime
                                    : Colors.blueGrey)),
                        onTap: _countdownTime == 0 ? _btnPress : null),
                  )
                ],
              )),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          child: TextButton(
            onPressed: (_recevPhonoe == null ||
                    _amount == null ||
                    NumUtil.getIntByValueStr(_realAmount) < 0)
                ? () {
                    Toast.warm("提币信息不正确");
                  }
                : () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: Text("请输入资金密码"),
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
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
                                  if (value.isEmpty || value == null) {
                                    return "资金密码不能为空";
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () {
                                      _withdraw();
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
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lime),
                textStyle:
                    MaterialStateProperty.all(TextStyle(color: Colors.white))),
            child: Text("确认提币"),
          ),
        )
      ],
    );
  }
}
