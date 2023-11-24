import 'package:cy_app/api/app.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  // final initPage;
  //
  // NewsPage({Key key, this.initPage}) : super(key: key);

  @override
  _NewsPageState createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  Map _news = {};
  int _id;

  _getNews(id) async {
    var result = await AppRequest.newsDetail(id);
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _news = result.data["result"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dynamic _args = ModalRoute.of(context).settings.arguments;
      _getNews(_args["news_id"]);
    });
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
          title: Text("详情"),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Text(
              _news.isEmpty ? "" : _news["title"],
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(SdopDateUtils().tsToDate((_news.isEmpty ? 0 : _news["ts"]) * 1000000))),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(_news.isEmpty ? "" : _news["content"])),
        ]),
      ),
    );
  }
}
