import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';

Widget recordStakedTableWidget(List tableData) {
  List<Widget> _rows = [];
  for (var item in tableData) {
    _rows.add(Container(
        padding: EdgeInsets.all(10),
        color: Color.fromARGB(255, 36, 38, 49),
        margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
        height: 100,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("币种: ${item['asset'].toString()}"),
                Text("订单数量: ${item['order_amount'].toString()}T"),
                Text("质押数量: ${item['amount'].toString()}T"),
              ],
            ),
            Container(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("质押消耗: ${item['staking_cost']}${item["asset"]}"),
                Text("${SdopDateUtils().tsToDate(item["ts"] * 1000000)}"),
              ],
            ),
            Container(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("开始时间: ${item['first_profit_day'].toString()}"),
                Text(
                    "结束时间: ${item['end_profit_day'].toString() == "0" ? "永久" : item['end_profit_day'].toString()}"),
              ],
            ),
          ],
        )));
  }

  return Column(
    children: _rows,
  );
}
