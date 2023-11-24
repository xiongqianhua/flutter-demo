import 'dart:async';
import 'package:cy_app/components/Toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/account.dart';

class FindPasswordPage extends StatefulWidget {
  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();
  String _userName;
  String _userPassword;
  String _validateCode;

  FocusNode _usernameTextBoxFocus = FocusNode();
  FocusNode _password1TextBoxFocus = FocusNode();
  FocusNode _validateTextBoxFocus = FocusNode();
  FocusNode _password2TextBoxFocus = FocusNode();
  Timer _timer;

  //倒计时数值
  var _countdownTime = 0;

  static bool isChinaPhoneLegal(String str) {
    bool _isTrue = false;
    if (str == null) {
      return _isTrue;
    }
    _isTrue = new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[0-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
    return _isTrue;
  }

  @override
  void initState() {
    super.initState();
  }

  _getValidateCode() async {
    var result = await AccountRequest.validateCode(
        {"phone": _userName, "business": "LPASS_RECOVER"});
    print(result);
  }

  _password() async {
    if (_passwordForm.currentState.validate()) {
      _passwordForm.currentState.save();
      var result = await AccountRequest.password({
        "phone": _userName,
        "password": EncryptUtil.encodeMd5(_userPassword),
        "code": _validateCode,
      });
      if (result.data["status"]["success"] == 1) {
        Toast.success("密码修改成功");
        print(result);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Future<bool> prefsRes = prefs.remove("userToken");
        if (prefsRes != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/login", (Route<dynamic> route) => false);
        }
      }
    }
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
          title: Text("修改密码"),
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
                                focusNode: _usernameTextBoxFocus,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.phone_android),
                                  hintText: '请输入手机号',
                                  labelText: '手机号',
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _userName = value;
                                  });
                                },
                                validator: (String value) {
                                  if (!isChinaPhoneLegal(value)) {
                                    return "输入正确的手机号";
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
                              TextFormField(
                                focusNode: _password1TextBoxFocus,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: '请输入密码',
                                  labelText: '请设置6-20位密码',
                                ),
                                obscureText: true,
                                onChanged: (String value) {
                                  setState(() {
                                    _userPassword = value;
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
                              TextFormField(
                                focusNode: _password2TextBoxFocus,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: '请输入密码',
                                  labelText: '再次输入密码',
                                ),
                                obscureText: true,
                                onChanged: (String value) {
                                  if (_userPassword != value) {
                                    return "两次密码不一致";
                                  }
                                  setState(() {
                                    _userPassword = value;
                                  });
                                },
                                validator: (String value) {
                                  if (value.isEmpty || value == null) {
                                    return "密码不能为空";
                                  }
                                  return null;
                                },
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
                                        _password();
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
