import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/Toast.dart';
import '../api/app.dart';
import '../utils/VersionUtil.dart';

import 'home/mainPage.dart';
import 'my/mainPage.dart';
import 'mall//mainPage.dart';
import 'discovery/mainPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> _title = ["首页", "商城", "发现", "我的"];
  int _currentIndex = 0;
  List _pageList = [HomePage(), MallPage(), DiscoveryPage(), MyPage()];
  PageController _controller = PageController(initialPage: 0);
  String newVersionUrl = "";

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    String newVersion = "";
    var result = await AppRequest.version();
    if (result.data["status"]["success"] == 1) {
      newVersion = result.data["result"]["version"];
      newVersionUrl = result.data["result"]["url"];
    }

    if (VersionUtil.compare(newVersion, currentVersion)) {
      _showNewVersionAppDialog();
    }
  }

  _download() async {
    if (await canLaunch(newVersionUrl)) {
      await launch(newVersionUrl);
    } else {
      Toast.warm("无法更新");
    }
  }

  Future<void> _showNewVersionAppDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          int downloadProgress = 0;
          return StatefulBuilder(builder: (context, mSetState) {
            print(downloadProgress);
            return WillPopScope(
                child: AlertDialog(
                  title: new Row(
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: new Text(
                            "版本更新",
                          ))
                    ],
                  ),
                  actions: <Widget>[
                    new TextButton(
                      child: new Text('下载更新'),
                      onPressed: () {
                        _download();
                      },
                    ),
                    new TextButton(
                      child: new Text('取消'),
                      onPressed: () async {
                        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      },
                    ),
                  ],
                ),
                onWillPop: () async {
                  return Future.value(false);
                });
          });
        });
  }

  void _checkPermission() async {
    // Map<PermissionGroup, PermissionStatus> permissions =
    //     await PermissionHandler().requestPermissions([
    //   PermissionGroup.camera,
    //   PermissionGroup.storage,
    // ]);
    // PermissionStatus permissionStorage =
    //     await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    // PermissionStatus permissionCamera =
    //     await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    //
    // if (permissionCamera == PermissionStatus.granted &&
    //     permissionStorage == PermissionStatus.granted) {
    //   print("权限获取成功");
    // } else {
    //   Toast.fail("请授权");
    //   await PermissionHandler().openAppSettings();
    // }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVersion();
      _checkPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Offstage(
            offstage: _currentIndex == 0 ? true : false,
            child: AppBar(),
          ),
          preferredSize: Size.zero),
      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: _pageChange,
          controller: _controller,
          itemCount: _pageList.length,
          itemBuilder: (context, index) => _pageList[index]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lime,
        backgroundColor: Color.fromARGB(255, 28, 33, 49),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.computer), label: ("首页")),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "商城"),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: ("发现")),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ("我的")),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          print(_title[index]);
          _controller.jumpToPage(index);
        },
      ),
    );
  }
}
