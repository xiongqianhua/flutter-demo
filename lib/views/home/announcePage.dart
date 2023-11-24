import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';

class AnnouncePage extends StatefulWidget {
  @override
  _AnnouncePageState createState() {
    return _AnnouncePageState();
  }
}

class _AnnouncePageState extends State<AnnouncePage> with TickerProviderStateMixin {
  Map _announce = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dynamic _args = ModalRoute.of(context).settings.arguments;
      setState(() {
        _announce = _args["announce"];
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.context;
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("公告详情"),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Text(
              _announce["title"] ?? "",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(SdopDateUtils().tsToDate((_announce["ts"] ?? 0) * 1000000))),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(_announce["content"] ?? "")),
        ]),
      ),
    );
  }
}
