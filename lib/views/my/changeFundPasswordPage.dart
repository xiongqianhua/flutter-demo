import 'dart:async';

import 'package:cy_app/components/Toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/account.dart';

class ChangeFundPasswordPage extends StatefulWidget {
  @override
  _ChangeFundPasswordPageState createState() => _ChangeFundPasswordPageState();
}

class _ChangeFundPasswordPageState extends State<ChangeFundPasswordPage> {
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();
  String _password;
  String _validateCode;

  FocusNode _passwordTextBoxFocus = FocusNode();
  FocusNode _validateTextBoxFocus = FocusNode();
  Timer _timer;

  //倒计时数值
  var _countdownTime = 0;

  @override
  void initState() {
    super.initState();
  }

  _getValidateCode() async {
    var result =
        await AccountRequest.validateLoginCode({"business": "FPASS_RECOVER"});
    print(result);
  }

  _changeFundPasswd() async {
    if (_passwordForm.currentState.validate()) {
      _passwordForm.currentState.save();
      var result = await AccountRequest.fund_password({
        "passwd": EncryptUtil.encodeMd5(_password),
        "code": _validateCode,
      });
      if (result.data["status"]["success"] == 1) {
        Toast.success("密码修改成功");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("fund_passwd", true);
        Navigator.of(context).pop(context);
      }
    }
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
  void dispose() {
    super.dispose();

    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("修改资金密码"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                    key: _passwordForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                focusNode: _passwordTextBoxFocus,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: '请输入密码',
                                  labelText: '请设置6-20位密码',
                                ),
                                obscureText: true,
                                onChanged: (String value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                validator: (String value) {
                                  if (value.isEmpty || value == null) {
                                    return "密码不能为空";
                                  }
                                  if (value.length < 6) {
                                    return "密码长度不能小于6位";
                                  }
                                  return null;
                                },
                              ),
                              Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: TextFormField(
                                      focusNode: _validateTextBoxFocus,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.shield),
                                        hintText: '请输入验证码',
                                        labelText: '验证码',
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _validateCode = value;
                                        });
                                      },
                                      validator: (String value) {
                                        if (value.isEmpty || value == null) {
                                          return "验证码不能为空";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      top: 6,
                                      child: TextButton(
                                          child: Text(
                                            handleCodeAutoSizeText(),
                                            style: TextStyle(
                                                color: _countdownTime == 0
                                                    ? Colors.lime
                                                    : Colors.blueGrey),
                                          ),
                                          onPressed: _countdownTime == 0
                                              ? _btnPress
                                              : null))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                width: double.infinity,
                                height: 45.0,
                                child: TextButton(
                                    child: Text(
                                      "修改密码",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16.0),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.yellow)),
                                    onPressed: () {
                                      if (_passwordForm.currentState
                                          .validate()) {
                                        _changeFundPasswd();
                                      }
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    )))
          ],
        ));
  }
}
