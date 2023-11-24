import 'package:cy_app/components/setting/SettingCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/Toast.dart';

class AssetHistoryPage extends StatefulWidget {
  final asset;

  const AssetHistoryPage({Key key, this.asset}) : super(key: key);

  @override
  _AssetHistoryPageState createState() => _AssetHistoryPageState();
}

class _AssetHistoryPageState extends State<AssetHistoryPage> with AutomaticKeepAliveClientMixin {
  Widget _historyCard() {
    return Column(children: <Widget>[
      Card(
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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextButton(
                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "提币记录",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 16.0,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/fund/record/withdraw', arguments: {"asset": widget.asset});
                },
              ))),
      Card(
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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextButton(
                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("充币记录", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 16.0,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/fund/record/deposit', arguments: {"asset": widget.asset});
                },
              )))
    ]);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _historyCard();
  }
}
