import 'package:cy_app/components/Toast.dart';
import 'package:cy_app/components/earningTabWidget.dart';
import 'package:cy_app/views/my/earning/clusterPage.dart';
import 'package:cy_app/views/my/earning/hashratePage.dart';
import 'package:cy_app/views/my/earning/promotionPage.dart';
import 'package:cy_app/views/my/earning/promotionPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hashratePage.dart';

class EarningPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EarningPageState();
  }
}

class _EarningPageState extends State<EarningPage>
    with SingleTickerProviderStateMixin {
  List productivityListData;
  int _currentIndex = 0;
  String _userRole;
  List _pdl = [
    Expanded(child: HashratePage()),
    Expanded(
        child: ClusterPage(
      category: "CLUSTER",
    )),
  ];

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString("user_role");
      if (_userRole == "CLUSTER") {
        _currentIndex = 1;
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Stack(alignment: Alignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Offstage(
                offstage: _userRole == "CLUSTER" ? true : false,
                child: GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(right: 15),
                      // width: 100,
                      child: Text(
                        "挖矿收益",
                        style: TextStyle(
                            fontSize: 18,
                            color: _currentIndex == 0
                                ? Colors.lime
                                : Colors.white),
                      )),
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                )),
            Offstage(
                offstage: _userRole == "MINER" ? true : false,
                child: GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Text(
                        "集群收益",
                        style: TextStyle(
                            fontSize: 18,
                            color: _currentIndex == 1
                                ? Colors.lime
                                : Colors.white),
                      )),
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                )),
          ],
        ),
        Positioned(
            right: 0,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/my/groupRecord",
                    arguments: {"category": _currentIndex});
              },
              child: Text(
                "团队收益",
                style: TextStyle(fontSize: 12, color: Colors.lime),
              ),
            ))
      ])),
      body: Column(
        children: <Widget>[_pdl[_currentIndex]],
      ),
    );
  }
}
