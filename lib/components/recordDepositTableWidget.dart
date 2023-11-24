import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Toast.dart';

Widget recordDepositTableWidget(List tableData) {
  List<Widget> _rows = [];
  for (var item in tableData) {
    _rows.add(Container(
        padding: EdgeInsets.all(10),
        color: Color.fromARGB(255, 36, 38, 49),
        margin: EdgeInsets.only(bottom: 5, top: 5),
        height: 65,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("数量: ${item['amount'].toString()} ${item["asset"]}"),
                Text("${SdopDateUtils().tsToDate(item["ts"] * 1000000)}"),
              ],
            ),
            Container(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(item['state'] == "NEW" ? "待审核" : (item['state'] == "COMPLETE" ? "充值完成" : "审核失败"))],
            ),
          ],
        )));
  }

  return Column(
    children: _rows,
  );
}
