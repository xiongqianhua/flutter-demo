import 'package:cy_app/api/account.dart';
import 'package:cy_app/components/setting/SettingCardWidget.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/Toast.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  String _userRealName = "Unkonw";
  String _userID = "0";
  String _level = "0";
  dynamic _profit;

  _getProfit() async {
    var result = await AccountRequest.balances();
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _profit = result.data["result"];
      });
    }
  }

  _genLevelStr(level) {
    switch (level.toString()) {
      case "-1":
        return "V0";
        break;
      case "0":
        return "V";
        break;
      default:
        return "V${level}";
        break;
    }
  }

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = await AccountRequest.getUserInfo();
    setState(() {
      _userRealName = userInfo.data["result"]["name"] ?? "Unkonw";
      _userID = userInfo.data["result"]["id"].toString() ?? "0";
      _level = _genLevelStr(userInfo.data["result"]["level"]);
      prefs.setString("userRealName", userInfo.data['result']['name']);
      prefs.setString("phone", userInfo.data['result']['phone']);
      prefs.setString("invite_code", userInfo.data['result']['invite_code']);
      prefs.setString("userID", userInfo.data['result']['id'].toString());
      prefs.setString("leveL", userInfo.data['result']['leveL'].toString());
      prefs.setString("user_role", userInfo.data['result']['user_role'].toString());
      prefs.setBool("fund_passwd", userInfo.data['result']['has_fund_passwd'] == 0 ? false : true);
    });
  }

  Widget _settingCard() {
    return Column(children: <Widget>[
      Card(
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
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(children: <Widget>[
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.white,
                          size: 16.0,
                        ),
                        Text(
                          "  我的挖矿",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 16.0,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/my/earning");
                },
              ),
              Container(
                  child: Divider(
                height: 2.0,
              )),
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.account_balance,
                          color: Colors.white,
                          size: 16.0,
                        ),
                        Text(
                          "  我的资产",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 16.0,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/my/asset");
                },
              ),
              Container(
                  child: Divider(
                height: 2.0,
              )),
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.add_shopping_cart_sharp,
                          color: Colors.white,
                          size: 16.0,
                        ),
                        Text("  我的订单", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 16.0,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/my/order");
                },
              ),
              Container(
                  child: Divider(
                height: 2.0,
              )),
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.add_location_outlined,
                          color: Colors.white,
                          size: 16.0,
                        ),
                        Text("  地址管理", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 16.0,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/my/address");
                },
              )
            ]),
          )),
      Card(
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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.supervisor_account_sharp,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            Text("  账户管理",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 16.0,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/account");
                    },
                  ),
                  Container(
                      child: Divider(
                    height: 2.0,
                  )),
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            Text("  设置", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 16.0,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/setting");
                    },
                  ),
                ],
              ))),
      Card(
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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.insert_invitation_outlined,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            Text("  邀请好友",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 16.0,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/invite');
                    },
                  ),
                  Container(
                      child: Divider(
                    height: 2.0,
                  )),
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.chat_outlined,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            Text("  联系客服",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 16.0,
                        )
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(20),
                                    child: Text("复制微信号并添加，即可获得您的专属客服")),
                                Container(
                                    alignment: Alignment.center,
                                    // padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Joker_ZJQ0912",
                                      // borderColor: Colors.yellow,
                                      // borderRadius: 5,
                                      // textStyle: TextStyle(fontSize: 18),
                                    )),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SimpleDialogOption(
                                        onPressed: () {
                                          ClipboardData data =
                                              new ClipboardData(
                                                  text: "Joker_ZJQ0912");
                                          Clipboard.setData(data);
                                          Toast.success("已复制");
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Text("复制"),
                                      ),
                                      SimpleDialogOption(
                                        onPressed: () {
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Text("取消"),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          });
                    },
                  )
                ],
              )))
    ]);
  }

  Widget profileHeader() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              child: Row(children: <Widget>[
            Container(
                margin: EdgeInsets.all(10),
                child: Icon(
                  Icons.account_box,
                  size: 60.0,
                )),
            Container(
                height: 40.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _userRealName,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      Row(
                        children: [
                          Text(
                            "UID:" + _userID,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                          Text(
                            " ${_level}",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        ],
                      )
                    ]))
          ])),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _getProfit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _popCount = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
        child: Container(
          padding: EdgeInsets.only(top: 15),
          child: RefreshIndicator(
              onRefresh: () async {
                await _getProfit();
                await _getUserInfo();
              },
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[profileHeader(), _settingCard()],
                  )
                ],
              )),
        ),
        onWillPop: () async {
          if (_popCount < 1) {
            Toast.success("再来一次退出");
            setState(() {
              _popCount++;
            });
            return Future.value(false);
          } else {
            return true;
          }
        });
    ;
  }
}
