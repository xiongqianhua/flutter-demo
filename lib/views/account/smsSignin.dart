import 'dart:async';

import 'package:cy_app/components/Toast.dart';
import 'package:flutter/material.dart';
import '../MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/account.dart';

class SMSSigninPage extends StatefulWidget {
  @override
  _SMSSigninPageState createState() => _SMSSigninPageState();
}

class _SMSSigninPageState extends State<SMSSigninPage> {
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  String _userName;
  String _validateCode;
  FocusNode _usernameTextBoxFocus = FocusNode();
  FocusNode _validateTextBoxFocus = FocusNode();

  Timer _timer;

  //倒计时数值
  int _countdownTime = 0;

  _login() async {
    _validateTextBoxFocus.unfocus();
    _usernameTextBoxFocus.unfocus();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_loginForm.currentState.validate()) {
      _loginForm.currentState.save();
      var token = await AccountRequest.smssignin({"phone": _userName.trim(), "code": _validateCode.trim()});
      if (token.data["status"]["success"] == 1) {
        prefs.setString("userToken", token.data['result']);
        var userInfo = await AccountRequest.getUserInfo();
        if (userInfo.data["status"]["success"] == 1) {
          prefs.setString("userRealName", userInfo.data['result']['name']);
          prefs.setString("phone", userInfo.data['result']['phone']);
          prefs.setString("invite_code", userInfo.data['result']['invite_code']);
          prefs.setString("leveL", userInfo.data['result']['leveL'].toString());
          prefs.setString("userID", userInfo.data['result']['id'].toString());
          prefs.setBool("fund_passwd", userInfo.data['result']['has_fund_passwd'] == 0 ? false : true);

          Navigator.pushAndRemoveUntil(
              context, new MaterialPageRoute(builder: (context) => new MainPage()), (route) => route == null);
        }
      }
    }
  }

  _getValidateCode() async {
    var result = await AccountRequest.validateCode({"phone": _userName, "business": "SIGNIN"});
    print(result);
  }

  _btnPress() {
    if (_userName == null || _userName.isEmpty) {
      return Toast.success("手机号不能为空");
    }

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("登录"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
                // color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                    key: _loginForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                focusNode: _usernameTextBoxFocus,
                                autofillHints: [AutofillHints.telephoneNumber],
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: '请输入手机号',
                                  labelText: '用户名',
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _userName = value;
                                  });
                                },
                                validator: (String value) {
                                  if (value.isEmpty || value == null) {
                                    return "用户名不能为空";
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
                                            style:
                                                TextStyle(color: _countdownTime == 0 ? Colors.lime : Colors.blueGrey),
                                          ),
                                          onPressed: _countdownTime == 0 ? _btnPress : null))
                                ],
                              ),
                              Container(
                                  // padding: EdgeInsets.only(top: 20.0),
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed('/account/password');
                                      },
                                      child: Text(
                                        "忘记密码?",
                                        style: TextStyle(color: Colors.lime, fontSize: 12),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                      },
                                      child: Text(
                                        "密码登录",
                                        style: TextStyle(color: Colors.lime, fontSize: 12),
                                      ))
                                ],
                              )),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                width: double.infinity,
                                child: TextButton(
                                  child: Text(
                                    "登录",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                                  onPressed: _login,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                width: double.infinity,
                                child: TextButton(
                                  child: Text(
                                    "注册",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("/signup");
                                  },
                                ),
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
