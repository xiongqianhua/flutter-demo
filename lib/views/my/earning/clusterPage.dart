import 'package:cy_app/api/account.dart';
import 'package:cy_app/components/earning/HashrateEarningCardWidget.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import '../../../components/earning/HashrateEarningCardWidget.dart';

class ClusterPage extends StatefulWidget {
  final category;

  ClusterPage({Key key, this.category}) : super(key: key);

  @override
  _ClusterPageState createState() => _ClusterPageState();
}

class _ClusterPageState extends State<ClusterPage> {
  List _hashrateData = [];
  dynamic result;

  _getHashrateData() async {
    if (widget.category == "CLUSTER") {
      result = await AccountRequest.mining_info(category: widget.category);
    } else {
      result = await AccountRequest.mining_info();
    }
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _hashrateData = result.data["result"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getHashrateData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _earningsWidget() {
    List<Widget> _earnings = [];
    if (_hashrateData.length == 0) {
      _earnings.add(Container(
        padding: EdgeInsets.only(top: 20),
        child: Text("你还没有开始挖矿"),
      ));
    }
    for (var item in _hashrateData) {
      _earnings.add(
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
                child: Column(
              children: <Widget>[
                HashrateEarningCardWidget.earningCard(
                  oneLabel: "有效算力(T)",
                  oneNum: item["power_in_progress"],
                  oneOnPress: () {
                    Navigator.of(context).pushNamed("/fund/record/profit");
                  },
                  twoLabel: "今日收益(${item["asset"]})",
                  twoNum: item["amount_yesterday_total"],
                  twoOnPress: () {
                    Navigator.of(context).pushNamed("/fund/record/profit");
                  },
                  threeLabel: "累计已释放(${item["asset"]})",
                  threeNum: item["profit_released"],
                  threeOnPress: () {
                    Navigator.of(context).pushNamed("/fund/record/profit");
                  },
                  fourLabel: "累计待释放(${item["asset"]})",
                  fourNum: item["profit_unreleased"],
                  fourOnPress: () {
                    Navigator.of(context).pushNamed("/fund/record/profit");
                  },
                  fiveLabel: "社区容量(T)",
                  fiveNum: item["community_valid_cap"]+"/"+item["community_bought_cap"],
                  fiveOnPress: () {
                    Navigator.of(context).pushNamed("/fund/record/profit");
                  },
                  sixLabel: "推广收益(${item["asset"]})",
                  sixNum: item["reward_amount"],
                  sixOnPress: () {
                    Navigator.of(context).pushNamed("/fund/record/profit");
                  },
                  fontColor: Colors.white,
                ),
              ],
            ))),
      );
    }
    return Column(children: _earnings);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _getHashrateData();
      },
      child: ListView(shrinkWrap: true, children: [
        Container(
            height: MediaQuery.of(context).size.height, child: _earningsWidget()
            )
      ]),
    );
  }
}
