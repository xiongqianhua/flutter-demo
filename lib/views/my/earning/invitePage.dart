import 'package:cy_app/api/app.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvitePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<InvitePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _inviteCode = "";
  String _downloadUrl = "";

  _getInviteInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _inviteCode = prefs.getString("invite_code");
    });
  }

  _getDownloadUrl() async {
    var result = await AppRequest.version();
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _downloadUrl = result.data["result"]["url"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getDownloadUrl();
    _getInviteInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Stack(alignment: Alignment.center, children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  '邀请码',
                )),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/inviteRecord");
                    },
                    child: Text("邀请记录",style: TextStyle(color: Colors.lime),)))
          ]),
        ),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      "邀请好友一起赚钱",
                      style: TextStyle(fontSize: 18.0, color: Colors.lime, height: 1),
                    ),
                    Text(
                      "邀请好友下载APP，获取额外奖励",
                      style: TextStyle(fontSize: 14.0, height: 2),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(image: new AssetImage('assets/image/invite-bg.png'), fit: BoxFit.fill)),
                child: QrImage(
                  data: _downloadUrl,
                  size: 200,
                  backgroundColor: Colors.white70,
                ),
                padding: EdgeInsets.only(top: 50, bottom: 20),
              ),
              Container(
                  width: 260,
                  padding: EdgeInsets.all(15),
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blueGrey.withOpacity(0.3)),
                          padding: MaterialStateProperty.all(EdgeInsets.only(top: 10, bottom: 10))),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                        Text(
                          _inviteCode,
                          style: TextStyle(color: Colors.lime, fontSize: 18),
                        ),
                        Icon(
                          Icons.copy_outlined,
                          color: Colors.lime,
                        )
                      ]),
                      onPressed: () {
                        ClipboardData data = new ClipboardData(text: _inviteCode);
                        Clipboard.setData(data);
                        Toast.success("邀请码已复制");
                      }))
            ],
          )),
    );
  }
}
