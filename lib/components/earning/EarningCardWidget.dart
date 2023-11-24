import 'package:flutter/material.dart';

class EarningCardWidget extends StatelessWidget {
  final firstLabel;
  final firstNum;
  final firstOnPress;
  final secondLabel;
  final secondNum;
  final secondOnPress;
  final thirdLable;
  final thirdNum;
  final thirdOnPress;
  final Color fontColor;

  EarningCardWidget.earningCard({
    Key key,
    this.firstLabel,
    this.firstNum,
    this.firstOnPress,
    this.secondLabel,
    this.secondNum,
    this.secondOnPress,
    this.thirdLable,
    this.thirdNum,
    this.thirdOnPress,
    this.fontColor = Colors.lime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: firstOnPress,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      firstLabel,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 10.0,
                    ),
                    Text(
                      firstNum.toString(),
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                    ),
                  ],
                ),
              ),
            ),
            flex: 33,
          ),
          Flexible(
            child: VerticalDivider(
              width: 1.0,
              indent: 20.0,
              endIndent: 30.0,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      thirdLable,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      height: 10.0,
                    ),
                    Text(
                      thirdNum.toString(),
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                    ),
                  ],
                ),
                onTap: thirdOnPress,
              ),
            ),
            flex: 33,
          ),
          Flexible(
            child: VerticalDivider(
              width: 1.0,
              indent: 20.0,
              endIndent: 30.0,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      secondLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      height: 10.0,
                    ),
                    Text(
                      secondNum.toString(),
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                    ),
                  ],
                ),
                onTap: secondOnPress,
              ),
            ),
            flex: 33,
          ),
        ],
      ),
      height: 120,
    );
  }
}
