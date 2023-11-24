import 'package:cy_app/components/Toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import '../MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/account.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  String _userName;
  String _userPassword;
  FocusNode _usernameTextBoxFocus = FocusNode();
  FocusNode _passwordTextBoxFocus = FocusNode();

  _login() async {
    _passwordTextBoxFocus.unfocus();
    _usernameTextBoxFocus.unfocus();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_loginForm.currentState.validate()) {
      _loginForm.currentState.save();
      var token = await AccountRequest.signin({
        "phone": _userName.trim(),
        "password": EncryptUtil.encodeMd5(_userPassword.trim()),
      });
      if (token.data["status"]["success"] == 1) {
        prefs.setString("userToken", token.data['result']);
        var userInfo = await AccountRequest.getUserInfo();
        if (userInfo.data["status"]["success"] == 1) {
          prefs.setString("userRealName", userInfo.data['result']['name']);
          prefs.setString("phone", userInfo.data['result']['phone']);
          prefs.setString("invite_code", userInfo.data['result']['invite_code']);
          prefs.setString("userID", userInfo.data['result']['id'].toString());
          prefs.setString("leveL", userInfo.data['result']['leveL'].toString());
          prefs.setString("user_role", userInfo.data['result']['user_role'].toString());
          prefs.setBool("fund_passwd", userInfo.data['result']['has_fund_passwd'] == 0 ? false : true);

          Navigator.pushAndRemoveUntil(
              context, new MaterialPageRoute(builder: (context) => new MainPage()), (route) => route == null);
        }
      }
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
                              TextFormField(
                                focusNode: _passwordTextBoxFocus,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: '请输入密码',
                                  labelText: '密码',
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
                                  return null;
                                },
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
                                        Navigator.of(context).pushNamed('/smslogin');
                                      },
                                      child: Text(
                                        "验证码登录",
                                        style: TextStyle(color: Colors.lime, fontSize: 12),
                                      ))
                                ],
                              )),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                width: double.infinity,
                                child: TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                                  child: Text(
                                    "登录",
                                    style: TextStyle(color: Colors.black),
                                  ),
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
