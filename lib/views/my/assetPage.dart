import 'package:cy_app/api/account.dart';
import 'package:cy_app/utils/MathUtil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAssetPage extends StatefulWidget {
  @override
  _MyAssetPageState createState() => _MyAssetPageState();
}

class _MyAssetPageState extends State<MyAssetPage>
    with AutomaticKeepAliveClientMixin {
  List _assetList = [];
  bool _hasFundPasswd = false;

  Widget _assetCard() {
    List<Widget> _assetListWidget = [];
    for (var a in _assetList) {
      _assetListWidget.add(Column(children: <Widget>[
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
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_balance,
                      size: 18.0,
                    ),
                    Text(
                      a["asset"],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "总资产",
                          style: TextStyle(fontSize: 14.0, height: 3.0),
                        ),
                        Text(
                          plusUtil(a["amount"], a["frozen"]).toString(),
                          style: TextStyle(fontSize: 16.0, height: 2.0),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "可用",
                          style: TextStyle(fontSize: 14.0, height: 3.0),
                        ),
                        Text(
                          a["amount"] == null ? "0.00" : a["amount"].toString(),
                          style: TextStyle(fontSize: 16.0, height: 2.0),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "冻结",
                          style: TextStyle(fontSize: 14.0, height: 3.0),
                        ),
                        Text(
                          a["frozen"] == null ? "0.00" : a["frozen"].toString(),
                          style: TextStyle(fontSize: 16.0, height: 2.0),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                    height: 25.0,
                    child: Divider(
                      height: 2.0,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        if (_hasFundPasswd) {
                          return Navigator.of(context)
                              .pushNamed('/my/asset/withdraw', arguments: {
                            "pageName": 0,
                            "balance": minusUtil(a["amount"], a["frozen"]),
                            "asset": a["asset"]
                          });
                        }
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
                                                EdgeInsets.only(bottom: 10),
                                            child: Text("未设置资金密码，前去设置?")),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SimpleDialogOption(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          "/fund/password");
                                                },
                                                child: Text("设置")),
                                            SimpleDialogOption(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(context);
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
                      },
                      child: Text(
                        "提币",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(70.0, 30.0)),
                          shape: MaterialStateProperty.all(StadiumBorder())),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/my/asset/deposit',
                            arguments: {"pageName": 1, "asset": a["asset"]});
                      },
                      child: Text(
                        "充币",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(70.0, 30.0)),
                          shape: MaterialStateProperty.all(StadiumBorder())),
                    ),
                    // OutlinedButton(
                    //   onPressed: () {
                    //     if (_hasFundPasswd) {
                    //       return Navigator.of(context)
                    //           .pushNamed('/my/asset/transfer', arguments: {
                    //         "pageName": 2,
                    //         "balance": minusUtil(a["amount"], a["frozen"]),
                    //         "asset": a["asset"]
                    //       });
                    //     }
                    //     showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) {
                    //           return SimpleDialog(
                    //             children: [
                    //               Container(
                    //                 padding: EdgeInsets.all(15),
                    //                 child: Column(
                    //                   children: [
                    //                     Container(
                    //                         padding:
                    //                             EdgeInsets.only(bottom: 10),
                    //                         child: Text("未设置资金密码，前去设置?")),
                    //                     Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         SimpleDialogOption(
                    //                             onPressed: () {
                    //                               Navigator.of(context)
                    //                                   .pushNamed(
                    //                                       "/fund/password");
                    //                             },
                    //                             child: Text("设置")),
                    //                         SimpleDialogOption(
                    //                             onPressed: () {
                    //                               Navigator.of(context)
                    //                                   .pop(context);
                    //                             },
                    //                             child: Text("取消"))
                    //                       ],
                    //                     )
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           );
                    //         });
                    //   },
                    //   child: Text(
                    //     "划转",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   style: ButtonStyle(
                    //       minimumSize:
                    //           MaterialStateProperty.all(Size(70.0, 30.0)),
                    //       shape: MaterialStateProperty.all(StadiumBorder())),
                    // ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/my/asset/history',
                            arguments: {"pageName": 2, "asset": a["asset"]});
                      },
                      child: Text(
                        "查询",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(70.0, 30.0)),
                          shape: MaterialStateProperty.all(StadiumBorder())),
                    ),
                  ],
                )
              ]),
            ))
      ]));
    }
    return ListView(
      children: _assetListWidget,
    );
  }

  @override
  bool get wantKeepAlive => true;

  _getAssetList() async {
    var balances = await AccountRequest.balances();
    if (balances.data["status"]["success"] == 1) {
      setState(() {
        _assetList = balances.data["result"];
      });
    }
  }

  _getfundPasswd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) {
      return;
    }
    setState(() {
      _hasFundPasswd = prefs.getBool("fund_passwd");
    });
  }

  @override
  void initState() {
    super.initState();
    _getfundPasswd();
    _getAssetList();
  }

  @override
  void deactivate() {
    _getfundPasswd();
    super.deactivate();
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
          "我的资产",
        ),
        elevation: 1,
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await _getAssetList();
          },
          child: _assetCard()),
    );
  }
}
