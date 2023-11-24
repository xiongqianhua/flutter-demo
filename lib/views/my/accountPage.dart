import 'package:flutter/material.dart';
import '../../components/Toast.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with AutomaticKeepAliveClientMixin {
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
                            Text(
                              "修改登录密码",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16.0,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/account/password");
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
                            Text(
                              "修改资金密码",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16.0,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/fund/password");
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
                            Text(
                              "设置昵称",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16.0,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/account/kyc");
                    },
                  )
                ],
              )))
    ]);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "账户管理",
          ),
          elevation: 1,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_settingCard()],
        ));
  }
}
