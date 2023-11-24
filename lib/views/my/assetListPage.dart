import 'package:cy_app/api/fund.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class AssetListPage extends StatefulWidget {
  const AssetListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AssetListPageState();
  }
}

class _AssetListPageState extends State<AssetListPage> with SingleTickerProviderStateMixin {
  List _assetList = [];

  _aeets() async {
    var result = await FundRequest.assetList();
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _assetList.addAll(result.data["result"]);
      });
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _aeets();
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
            "币种列表",
          ),
          elevation: 1,
        ),
        body: Column(children: <Widget>[
          Flexible(
              child: FractionallySizedBox(
                  heightFactor: 1,
                  child: _assetList.length == 0
                      ? Container(
                          child: Text("没有更多数据"),
                        )
                      : ListView.builder(
                          itemCount: _assetList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.pop(context, _assetList[index]["asset"]);
                              },
                              child: Card(
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
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text("币种: ${_assetList[index]["asset"]}"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ))),
        ]));
  }
}
