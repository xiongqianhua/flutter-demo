import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class AnnounceWidget extends StatefulWidget {
  final List announce;

  const AnnounceWidget({Key key, this.announce}) : super(key: key);

  @override
  _AnnounceWidgetState createState() => _AnnounceWidgetState();
}

class _AnnounceWidgetState extends State<AnnounceWidget> with AutomaticKeepAliveClientMixin {
  List<Widget> _announceWidgetList = [];

  _getAnnounceData() {
    for (var a in widget.announce) {
      _announceWidgetList.add(Text(a["title"]));
    }
  }

  @override
  void initState() {
    super.initState();
    _getAnnounceData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Text("公告: ",
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 118, 120, 130))),
                  Container(
                      height: 26,
                      alignment: Alignment.centerLeft,
                      child: CarouselSlider.builder(
                        key: UniqueKey(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Text(widget.announce.length == 0 ? "这里会显示公告的标题" : widget.announce[index]["title"]),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/announce', arguments: {"announce": widget.announce[index]});
                            },
                          );
                        },
                        itemCount: widget.announce.length,
                        options: CarouselOptions(
                            scrollPhysics: NeverScrollableScrollPhysics(),
                            aspectRatio: 8,
                            disableCenter: false,
                            scrollDirection: Axis.vertical),
                      )),
                ],
              ),
              TextButton(
                child: Text(
                  "查看更多>>",
                  style: TextStyle(fontSize: 12.0, color: Colors.yellow),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/announces');
                },
              )
            ]));
  }
}
