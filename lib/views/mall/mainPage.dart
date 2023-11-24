import 'package:cy_app/components/Toast.dart';
import 'package:cy_app/views/mall/InnovationProductListPage.dart';
import 'package:cy_app/views/mall/ProductListPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ClusterProductListPage.dart';

class MallPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MallPageState();
  }
}

class _MallPageState extends State<MallPage>
    with SingleTickerProviderStateMixin {
  List productivityListData;
  String _userRole;
  int _cindex = 0;

  List _pdl = [
    Expanded(
        child: ProductListPage(
      category: "MAIN",
    )),
    Expanded(
        child: InnovationProductListPage(
      category: "INNOVATION",
    )),
    Expanded(
        child: ClusterProductListPage(
      category: "CLUSTER",
    ))
  ];

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString("user_role");
    });
    _cindex = _userRole == "CLUSTER" ? 2 : 0;
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _popCount = 0;

  @override
  Widget build(BuildContext context) {
    print("bbbbb"+_cindex.toString());
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Offstage(
                    offstage: _userRole == "CLUSTER" ? true : false,
                    child: GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(right: 15),
                          // width: 100,
                          child: Text(
                            "主流区",
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    _cindex == 0 ? Colors.lime : Colors.white),
                          )),
                      onTap: () {
                        setState(() {
                          _cindex = 0;
                        });
                      },
                    )),
                Offstage(
                    offstage: _userRole == "CLUSTER" ? true : false,
                    child: GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Text(
                            "创新区",
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    _cindex == 1 ? Colors.lime : Colors.white),
                          )),
                      onTap: () {
                        setState(() {
                          _cindex = 1;
                        });
                      },
                    )),
                Offstage(
                    offstage: _userRole == "MINER" ? true : false,
                    child: GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Text(
                            "集群",
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    _cindex == 2 ? Colors.lime : Colors.white),
                          )),
                      onTap: () {
                        setState(() {
                          _cindex = 2;
                        });
                      },
                    )),
              ],
            )),
            body: Column(
              children: [_pdl[_cindex]],
            )),
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
  }
}
