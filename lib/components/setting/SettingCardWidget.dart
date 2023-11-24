import 'package:flutter/material.dart';

class SettingCardWidget extends StatelessWidget {
  final firstLeftLabel;
  final firstLeftNum;
  final firstLeftOnPress;
  final secondLeftLabel;
  final secondLeftNum;
  final secondLeftOnPress;
  final firstRightLabel;
  final firstRightNum;
  final firstRightOnPress;
  final secondRightLabel;
  final secondRightNum;
  final secondRightOnPress;
  final Color fontColor;

  SettingCardWidget.earningCard({
    Key key,
    this.firstLeftLabel,
    this.firstLeftNum,
    this.firstLeftOnPress,
    this.secondLeftLabel,
    this.secondLeftNum,
    this.secondLeftOnPress,
    this.firstRightLabel,
    this.firstRightNum,
    this.firstRightOnPress,
    this.secondRightLabel,
    this.secondRightNum,
    this.secondRightOnPress,
    this.fontColor = Colors.lime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: firstLeftOnPress,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "$firstLeftLabel(USDT)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Text(
                          firstLeftNum.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: fontColor),
                        ),
                      ],
                    ),
                  ),
                ),
                flex: 50,
              ),
              SizedBox(
                child: VerticalDivider(
                  width: 1,
                  indent: 10.0,
                  endIndent: 0,
                  color: Colors.lime.withAlpha(30),
                ),
                width: 10,
                height: 85,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${firstRightLabel}(USDT)",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Text(
                          firstRightNum.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: fontColor),
                        ),
                      ],
                    ),
                    onTap: firstRightOnPress,
                  ),
                ),
                flex: 50,
              ),
            ],
          ),
          Divider(
            height: 1,
            indent: 10.0,
            endIndent: 10,
            color: Colors.lime.withAlpha(30),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: secondLeftOnPress,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${secondLeftLabel}(FIL)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Text(
                          secondLeftNum.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: fontColor),
                        ),
                      ],
                    ),
                  ),
                ),
                flex: 50,
              ),
              SizedBox(
                child: VerticalDivider(
                  width: 1,
                  indent: 0.0,
                  endIndent: 10,
                  color: Colors.lime.withAlpha(30),
                ),
                width: 10,
                height: 85,
              ),
              Expanded(
                child: Container(
                  // height: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${secondRightLabel}(FIL)",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Text(
                          secondRightNum.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: fontColor),
                        ),
                      ],
                    ),
                    onTap: secondRightOnPress,
                  ),
                ),
                flex: 50,
              ),
            ],
          ),
        ],
      ),
      height: 180,
    );
  }
}
