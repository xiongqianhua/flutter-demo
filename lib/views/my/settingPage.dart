import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/Toast.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _currentVersion = "1.0";

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userToken").then((val) => {
          if (val) {Navigator.of(context).pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false)}
        });
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _currentVersion = packageInfo.version;
    });
  }

  Widget _settingCard() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
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
                            Text(
                              "  用户反馈",
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
                      Navigator.of(context).pushNamed("/feedback");
                    },
                  )
                ],
              ))),
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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
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
                            Text(
                              "  版本信息",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "v$_currentVersion",
                              style: TextStyle(color: Colors.lime),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.white,
                              size: 16.0,
                            )
                          ],
                        )
                      ],
                    ),
                    onPressed: () {
                      Toast.success("已是最新版本");
                    },
                  )
                ],
              )))
    ]);
  }

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "设置",
        ),
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[_settingCard()],
      ),
      bottomNavigationBar: TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text("确认退出"),
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("取消"),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                _logout();
                              },
                              child: Text("退出"),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                });
          },
          child: Text(
            "退出登录",
            style: TextStyle(color: Colors.blueGrey),
          )),
    );
  }
}
