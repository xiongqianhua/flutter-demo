import 'package:flutter/material.dart';

class EarningCardWidget extends StatelessWidget {
  final firstLabel;
  final firstNum;
  final firstOnPress;
  final secondLabel;
  final secondNum;
  final secondOnPress;
  Color fontColor;

  EarningCardWidget.earningCard({
    Key key,
    this.firstLabel,
    this.firstNum,
    this.firstOnPress,
    this.secondLabel,
    this.secondNum,
    this.secondOnPress,
    this.fontColor = Colors.lime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(15.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: firstOnPress,
                child: Column(
                  children: <Widget>[
                    Text(
                      firstLabel,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 10.0,
                    ),
                    Text(
                      firstNum.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: fontColor),
                    ),
                  ],
                ),
              ),
            ),
            flex: 50,
          ),
          Flexible(
            child: VerticalDivider(
              endIndent: 10,
              width: 0,
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(15.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: <Widget>[
                    Text(
                      secondLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 10.0,
                    ),
                    Text(
                      secondNum.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: fontColor),
                    ),
                  ],
                ),
                onTap: secondOnPress,
              ),
            ),
            flex: 50,
          ),
        ],
      ),
      height: 90,
    );
  }
}
