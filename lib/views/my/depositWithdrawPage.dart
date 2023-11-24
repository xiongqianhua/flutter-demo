import 'package:cy_app/views/my/assetHistory.dart';
import 'package:cy_app/views/my/depositPage.dart';
import 'package:cy_app/views/my/innerTransferPage.dart';
import 'package:cy_app/views/my/withdrawPage.dart';
import 'package:flutter/material.dart';

class DepositWithdrawPage extends StatefulWidget {
  @override
  _DepositWithdrawPageState createState() {
    return _DepositWithdrawPageState();
  }
}

class _DepositWithdrawPageState extends State<DepositWithdrawPage>
    with TickerProviderStateMixin {
  List productivityListData;
  TabController _tabController;
  String _balance;
  String _asset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    // _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.context;
    dynamic _args = ModalRoute.of(context).settings.arguments;
    setState(() {
      _balance = _args["balance"];
      _asset = _args["asset"];
      _tabController = new TabController(
          length: 3, vsync: this, initialIndex: _args["pageName"]);
    });

    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("提币充币"),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.lime,
            unselectedLabelColor: Colors.white,
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white54,
            indicatorWeight: 1.0,
            indicator:
                BoxDecoration(border: Border.all(style: BorderStyle.none)),
            tabs: <Widget>[
              Tab(
                text: "提币",
              ),
              Tab(
                text: "充币",
              ),
              // Tab(
              //   text: "划转",
              // ),
              Tab(
                text: "查询",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            WithdrawPage(
              balance: _balance,
              asset: _asset,
            ),
            DepositPage(
              asset: _asset,
            ),
            // InnerTransferPage(
            //   balance: _balance,
            //   asset: _asset,
            // ),
            AssetHistoryPage(asset: _asset)
          ],
        ),
      ),
    );
  }
}
