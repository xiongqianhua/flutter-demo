import 'package:cy_app/api/fund.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget recordWithdrawTableWidget(
    List tableData, String asset, BuildContext context) {
  List<Widget> _rows = [];
  _cancel(wid) async {
    var result = await FundRequest.cancelWithdraw(wid);
    if (result.data["status"]["success"] == 1) {
      Toast.success("提币已取消");
      // await refreshFunc;
      return true;
    }
    Toast.warm("提币无法取消");
    return false;
  }

  _refreshData() async {
    var result =
        await FundRequest.record(0, 10, category: "WITHDRAWAL", asset: asset);
    if (result.data["status"]["success"] == 1) {
      if (result.data["result"]["data"].length == 0) {
        return false;
      }
      tableData = result.data["result"]["data"];
      return true;
    }
  }

  _stateConvert(state, {id}) {
    switch (state) {
      case "NEW":
        return TextButton(
            child: Text(
              "取消",
              style: TextStyle(color: Colors.lime),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(title: Text("取消提币?"), children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SimpleDialogOption(
                              onPressed: () async {
                                _cancel(id);
                                _refreshData();
                                Navigator.of(context).pop(context);
                              },
                              child: Text("确认")),
                          SimpleDialogOption(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Text("取消"))
                        ],
                      )
                    ]);
                  });
            });
        break;
      case "PASS":
        return Text(
          "已通过",
          style: TextStyle(color: Colors.green),
        );
        break;
      case "CANCELLED":
        return Text("已取消", style: TextStyle(color: Colors.grey));
        break;
      case "SENT":
        return Text("已发送", style: TextStyle(color: Colors.grey));
        break;
      case "COMPLETE":
        return Text("已完成", style: TextStyle(color: Colors.green));
        break;
      case "REFUSE":
        return Text("已拒绝", style: TextStyle(color: Colors.red));
        break;
      default:
        return Text("进行中", style: TextStyle(color: Colors.grey));
        break;
    }
  }

  for (var item in tableData) {
    _rows.add(Container(
        margin: EdgeInsets.only(top: 5),
        height: 90,
        alignment: Alignment.center,
        child: TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 36, 38, 49))),
            onPressed: () {
              ClipboardData data =
                  new ClipboardData(text: item['txid'].toString());
              Clipboard.setData(data);
              Toast.success("交易ID已复制");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "数量: ${item['amount'].toString()} ${item["asset"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text("${SdopDateUtils().tsToDate(item["ts"] * 1000000)}",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                Container(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        item['txid'].length < 16
                            ? "交易ID:${item['txid'].toString()}"
                            : "交易ID:${item['txid'].toString().replaceRange(8, item['txid'].toString().length - 8, "...")}",
                        style: TextStyle(color: Colors.white)),
                    _stateConvert(item["state"], id: item["id"])
                  ],
                ),
              ],
            ))));
  }
  return ListView(children: <Widget>[
    Column(
      children: _rows,
    ),
    Offstage(
      offstage: tableData.length == 0 ? false : true,
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Text(
          "没有更多数据",
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ]);
}
