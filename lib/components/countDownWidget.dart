import 'dart:async';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';

class CountDownWidget extends StatefulWidget {
  final seconds;

  CountDownWidget({Key key, this.seconds}) : super(key: key);

  @override
  _CountDownWidgetState createState() {
    return _CountDownWidgetState();
  }
}

class _CountDownWidgetState extends State<CountDownWidget> {
  int hours = 0;
  int mins = 0;
  int second = 0;
  int _seconds = 0;
  Timer _timer;

  // _genData() {
  //   setState(() {
  //
  //   });
  // }

  void startTimer() {
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // _genData();
      //更新界面
      if (_seconds == 0) {
        //倒计时秒数为0，取消定时器
        cancelTimer();
      }
      setState(() {
        hours = _seconds ~/ 3600;
        mins = (_seconds % 3600) ~/ 60;
        second = _seconds % 60;
        //秒数减一，因为一秒回调一次
        _seconds--;
      });
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _seconds = widget.seconds;
    });
    startTimer();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          TextTagWidget(
            NumUtil.getIntByValueStr(hours.toString()).toString(),
            backgroundColor: Colors.lime.withOpacity(0.5),
            borderRadius: 5.0,
            padding: EdgeInsets.all(5.0),
            textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300),
          ),
          Text("小时", style: TextStyle(color: Colors.lime)),
          TextTagWidget(
            NumUtil.getIntByValueStr(mins.toString()).toString(),
            backgroundColor: Colors.lime.withOpacity(0.5),
            borderRadius: 5.0,
            padding: EdgeInsets.all(5.0),
            textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300),
          ),
          Text("分", style: TextStyle(color: Colors.lime)),
          TextTagWidget(
            NumUtil.getIntByValueStr(second.toString()).toString(),
            backgroundColor: Colors.lime.withOpacity(0.5),
            borderRadius: 5.0,
            padding: EdgeInsets.all(5.0),
            textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300),
          ),
          Text("秒", style: TextStyle(color: Colors.lime)),
        ],
      ),
    );
  }
}
