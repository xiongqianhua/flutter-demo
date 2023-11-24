import 'package:flutter/material.dart';
import '../../utils/DateUtil.dart';

Widget earningTableWidget(List tableData) {
  List<TableRow> _rows = [];
  _rows.add(TableRow(decoration: BoxDecoration(color: Color.fromARGB(255, 38, 40, 54)), children: [
    Container(height: 35, alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: 10), child: Text("时间")),
    Container(height: 35, alignment: Alignment.centerRight, child: Text('数量')),
    Container(
        height: 35,
        alignment: Alignment.center,
        child: Text(
          '状态',
        )),
  ]));
  for (var item in tableData) {
    _rows.add(TableRow(decoration: BoxDecoration(color: Color.fromARGB(255, 38, 40, 54)), children: [
      Container(
          height: 35,
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(SdopDateUtils().tsToDate(item["ts"] * 1000000))),
      Container(height: 30, alignment: Alignment.centerRight, child: Text("${item["amount"]} ${item["asset"]}")),
      Container(height: 30, alignment: Alignment.center, child: Text(item["state"] == "COMPLETE" ? "已发放" : "未发放")),
    ]));
  }
  return Column(children: <Widget>[
    Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(150.0),
              1: FixedColumnWidth(100.0),
              2: FixedColumnWidth(50.0),
              3: FixedColumnWidth(50.0),
            },
            children: _rows)),
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
