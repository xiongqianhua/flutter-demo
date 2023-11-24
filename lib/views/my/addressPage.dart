import 'package:cy_app/api/fund.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class AddressPage extends StatefulWidget {
  final isNotWithdraw;

  const AddressPage({Key key, this.isNotWithdraw = true}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddressPageState();
  }
}

class _AddressPageState extends State<AddressPage> with SingleTickerProviderStateMixin {
  List productivityListData;
  List _addressList = [];
  int _page = 0;
  EasyRefreshController _controller;

  _address() async {
    var result = await FundRequest.addressList(_page, 15);
    if (result.data["status"]["success"] == 1) {
      if (result.data["result"]["data"].length == 0) {
        return false;
      }
      setState(() {
        _addressList.addAll(result.data["result"]["data"]);
      });
      return true;
    }
  }

  _deleteAddress(id) async {
    var result = await FundRequest.deleteAddress(id);
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _addressList = [];
      });
      await _address();
      Toast.success("删除成功");
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _address();
  }

  @override
  void dispose() {
    _controller.dispose();
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
      body: Column(
        children: <Widget>[
          Flexible(
            child: FractionallySizedBox(
                heightFactor: 1,
                child: _addressList.length == 0
                    ? Container(
                        child: Text("没有更多数据"),
                      )
                    : EasyRefresh(
                        controller: _controller,
                        enableControlFinishLoad: true,
                        enableControlFinishRefresh: false,
                        header: ClassicalHeader(
                            textColor: Colors.white,
                            refreshedText: "刷新完成",
                            refreshFailedText: "刷新失败",
                            refreshingText: "正在刷新",
                            refreshReadyText: "准备刷新",
                            refreshText: "刷新"),
                        footer: ClassicalFooter(
                            textColor: Colors.white,
                            loadedText: "加载完成",
                            loadFailedText: "加载失败",
                            loadingText: "加载中",
                            loadReadyText: "准备加载",
                            loadText: "加载",
                            noMoreText: "没有更多数据"),
                        onRefresh: () async {
                          setState(() {
                            _page = 0;
                            _addressList.clear();
                          });
                          await _address();
                          _controller.resetLoadState();
                        },
                        onLoad: () async {
                          setState(() {
                            _page++;
                          });
                          var isMore = await _address();
                          _controller.finishLoad(noMore: isMore);
                        },
                        child: ListView.builder(
                          itemCount: _addressList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
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
                                                    Text("币种: ${_addressList[index]["asset"]}"),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text("备注: ${_addressList[index]["remark"]}"),
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top: 10),
                                                  width: 110,
                                                  child: Text(
                                                    _addressList[index]["address"].toString().length > 12
                                                        ? _addressList[index]["address"].toString().replaceRange(6,
                                                            _addressList[index]["address"].toString().length - 4, "...")
                                                        : _addressList[index]["address"].toString(),
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(children: [
                                              Offstage(
                                                child: Container(
                                                    height: 30,
                                                    width: 78,
                                                    child: RaisedButton(
                                                      color: Colors.lime,
                                                      onPressed: () {
                                                        Navigator.pop(context, _addressList[index]["address"]);
                                                      },
                                                      child: Text(
                                                        "选择",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      shape: StadiumBorder(),
                                                    )),
                                                offstage: widget.isNotWithdraw,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(left: 5),
                                                  height: 30,
                                                  width: 78,
                                                  child: RaisedButton(
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return Container(
                                                              padding: EdgeInsets.all(15),
                                                              child: SimpleDialog(
                                                                  title: Text(
                                                                    "是否删除地址？",
                                                                    style: TextStyle(fontSize: 14),
                                                                  ),
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        SimpleDialogOption(
                                                                          onPressed: () {
                                                                            _deleteAddress(_addressList[index]["id"]);
                                                                            Navigator.of(context).pop(context);
                                                                            _address();
                                                                          },
                                                                          child: Text("确认"),
                                                                        ),
                                                                        SimpleDialogOption(
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop(context);
                                                                          },
                                                                          child: Text("取消"),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ]),
                                                            );
                                                          });
                                                    },
                                                    child: Text(
                                                      "删除",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    shape: StadiumBorder(),
                                                  ))
                                            ])
                                          ],
                                        ),
                                        Container(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  )),
                              onTap: () {
                                ClipboardData data = new ClipboardData(text: _addressList[index]["address"].toString());
                                Clipboard.setData(data);
                                Toast.success("提币地址已复制");
                              },
                            );
                          },
                        ))),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/my/address/add");
              },
              child: Text(
                "添加提币地址",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
            ),
          )
        ],
      ),
    );
  }
}
