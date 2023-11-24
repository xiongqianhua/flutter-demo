import 'package:flutter/material.dart';

class HashrateEarningCardWidget extends StatelessWidget {
  final oneLabel;
  final oneNum;
  final oneOnPress;
  final twoLabel;
  final twoNum;
  final twoOnPress;
  final threeLabel;
  final threeNum;
  final threeOnPress;
  final fourLabel;
  final fourNum;
  final fourOnPress;
  final fiveLabel;
  final fiveNum;
  final fiveOnPress;
  final sixLabel;
  final sixNum;
  final sixOnPress;
  final fontColor;

  HashrateEarningCardWidget.earningCard({
    Key key,
    this.oneLabel,
    this.oneNum,
    this.oneOnPress,
    this.twoLabel,
    this.twoNum,
    this.twoOnPress,
    this.threeLabel,
    this.threeNum,
    this.threeOnPress,
    this.fourLabel,
    this.fourNum,
    this.fourOnPress,
    this.fiveLabel,
    this.fiveNum,
    this.fiveOnPress,
    this.sixLabel,
    this.sixNum,
    this.sixOnPress,
    this.fontColor = Colors.lime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Container(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: oneOnPress,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        oneLabel,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(
                        oneNum.toString(),
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                      ),
                    ],
                  ),
                ),
              ),
              flex: 33,
            ),
            Expanded(
              child: Container(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        twoLabel,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(
                        twoNum.toString(),
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                      ),
                    ],
                  ),
                  onTap: twoOnPress,
                ),
              ),
              flex: 33,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        threeLabel,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(
                        threeNum.toString(),
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                      ),
                    ],
                  ),
                  onTap: threeOnPress,
                ),
              ),
              flex: 33,
            )
          ]),
          Row(children: <Widget>[
            Expanded(
              child: Container(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: fourOnPress,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        fourLabel,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(
                        fourNum.toString(),
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                      ),
                    ],
                  ),
                ),
              ),
              flex: 33,
            ),
            Expanded(
              child: Container(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        fiveLabel,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(
                        fiveNum.toString(),
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                      ),
                    ],
                  ),
                  onTap: fiveOnPress,
                ),
              ),
              flex: 33,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        sixLabel,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(
                        sixNum.toString(),
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
                      ),
                    ],
                  ),
                  onTap: sixOnPress,
                ),
              ),
              flex: 33,
            )
          ]),
        ],
      ),
      height: 160,
    );
  }
}
