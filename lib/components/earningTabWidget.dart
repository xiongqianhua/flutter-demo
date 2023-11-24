import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EarningTabWidget extends StatefulWidget {
  final double height;
  final moreString;
  final tabController;
  final cindex;

  EarningTabWidget(
      {Key key,
      this.cindex,
      this.height = 35.0,
      this.moreString,
      this.tabController})
      : super(key: key);

  @override
  _EarningTabWidgetState createState() {
    return _EarningTabWidgetState();
  }
}

class _EarningTabWidgetState extends State<EarningTabWidget> {
  String _userRole;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString("user_role");
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      child: Stack(
        alignment: Alignment.lerp(Alignment.center, Alignment.centerLeft, 0.4),
        children: <Widget>[
          Positioned(
              right: 0,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/my/groupRecord",
                      arguments: {"category": _userRole});
                },
                child: Text(
                  widget.moreString,
                  style: TextStyle(fontSize: 12, color: Colors.lime),
                ),
              )),
          Container(
              width: 165,
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.blueGrey)),
              child: TabBar(
                controller: widget.tabController,
                isScrollable: false,
                labelColor: Colors.lime,
                labelStyle: TextStyle(fontSize: 12),
                unselectedLabelColor: Colors.white,
                // indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  border: Border.all(color: Colors.lime),
                ),
                // indicatorColor: Colors.white54,
                // indicatorWeight: 2.0,
                tabs: <Widget>[
                  Offstage(
                      offstage: _userRole == "CLUSTER" ? true : false,
                      child: Tab(
                        text: "挖矿收益",
                      )),
                  Offstage(
                      offstage: _userRole == "MINER" ? true : false,
                      child: Tab(
                        text: "集群收益",
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
