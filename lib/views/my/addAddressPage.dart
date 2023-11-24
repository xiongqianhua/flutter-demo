import 'package:cy_app/api/fund.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:flutter/material.dart';

import 'assetListPage.dart';

class AddAddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddAddressPageState();
  }
}

class _AddAddressPageState extends State<AddAddressPage> with SingleTickerProviderStateMixin {
  String _address;
  String _remark;
  String _asset;
  List _assets = [];

  _assetList() async {
    var result = await FundRequest.assetList();
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _assets = result.data["result"];
        _asset = result.data["result"][0]["asset"];
      });
    }
  }

  _navigateToAsset(BuildContext context) async {
    _asset = await Navigator.push(context, MaterialPageRoute(builder: (context) => AssetListPage()));
    setState(() {
      _asset=_asset;
    });
  }

  _addAddress() async {
    var result = await FundRequest.address({"asset": _asset, "address": _address, "remark": _remark, "memo": ""});
    if (result.data["status"]["success"] == 1) {
      Toast.success("地址添加成功");
    } else {
      Toast.fail("地址添加失败");
    }
  }

  @override
  void initState() {
    super.initState();
    _assetList();
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
            "提币地址",
          ),
          elevation: 1,
        ),
        body: Column(children: [
          Flexible(
            child: FractionallySizedBox(
                child: ListView(
              children: <Widget>[
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
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.radio_button_checked,
                                size: 16.0,
                                color: Colors.lime,
                              ),
                              Text("  选择币种"),
                            ],
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: () {
                                _navigateToAsset(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "  ${_asset}",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16.0,
                                    color: Colors.lime,
                                    semanticLabel: "aa",
                                  ),
                                ],
                              ),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black12)),
                            ),
                          ),
                          Container(
                            height: 20.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.radio_button_checked,
                                size: 16.0,
                                color: Colors.lime,
                              ),
                              Text("  钱包地址"),
                            ],
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Container(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _address = value;
                                });
                              },
                              minLines: 5,
                              maxLines: 10,
                              decoration: InputDecoration(hintText: "输入钱包地址", border: OutlineInputBorder()),
                            ),
                          ),
                          Container(
                            height: 20.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.radio_button_checked,
                                size: 16.0,
                                color: Colors.lime,
                              ),
                              Text("  备注"),
                            ],
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Container(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _remark = value;
                                });
                              },
                              minLines: 5,
                              maxLines: 10,
                              decoration: InputDecoration(hintText: "钱包备注", border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            )),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                _addAddress();
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              child: Text(
                "保存",
              ),
            ),
          )
        ]));
  }
}
