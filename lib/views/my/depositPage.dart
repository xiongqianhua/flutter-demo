import 'dart:io';
import 'package:path/path.dart';
import 'package:cy_app/api/fund.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/Toast.dart';

class DepositPage extends StatefulWidget {
  final asset;

  const DepositPage({Key key, this.asset}) : super(key: key);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> with AutomaticKeepAliveClientMixin {
  Map _address = {};
  File _image;
  String _fromAddress;
  TextEditingController _typeController;
  String _fundingPass;
  dynamic _amount;
  final GlobalKey<RefreshIndicatorState> _depositRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  String _chianName = "TRC20";

  @override
  bool get wantKeepAlive => true;

  _getDepositAddress() async {
    var result = await FundRequest.deposit(widget.asset);
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _typeController = TextEditingController.fromValue(TextEditingValue(text: widget.asset));
        _address = result.data["result"];
      });
    }
  }

  Future _getImage() async {
    final imagePicker = ImagePicker();
    var image = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  Future _deposit() async {
    FormData formdata = FormData.fromMap({
      "asset": widget.asset,
      "amount": _amount,
      "address": _fromAddress,
      "fund_passwd": EncryptUtil.encodeMd5(_fundingPass),
      "img": await MultipartFile.fromFile(_image.path, filename: basename(_image.path))
    });
    var result = await FundRequest.doDeposit(formdata);
    if (result.data["status"]["success"] == 1) {
      Toast.success("充值请求已提交");
    }
  }

  @override
  void initState() {
    super.initState();
    _getDepositAddress();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _depositRefreshIndicatorKey,
      onRefresh: () async {
        await _getDepositAddress();
      },
      child: ListView(
        children: <Widget>[
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
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 60.0,
                            child: Text("币种"),
                          ),
                          TextTagWidget(
                            widget.asset,
                            borderRadius: 5,
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                          )
                        ],
                      ),
                      Offstage(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              child: Text("链名称"),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _chianName = "TRC20";
                                });
                              },
                              child: TextTagWidget(
                                "TRC20",
                                borderRadius: 5,
                                backgroundColor: _chianName == "TRC20" ? Colors.lime : Colors.blueGrey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        offstage: widget.asset == "USDT" ? false : true,
                      ),
                      Container(
                          height: 25.0,
                          child: Divider(
                            height: 2.0,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("充币地址"),
                          OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                _address["address" ?? "-"],
                                style: TextStyle(color: Colors.white),
                              )),
                          OutlinedButton(
                            onPressed: () {
                              ClipboardData data = new ClipboardData(text: _address["address"]);
                              Clipboard.setData(data);
                              Toast.success("地址复制成功");
                            },
                            child: Text(
                              "复制地址",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blueGrey.withOpacity(0.3))),
                          )
                        ],
                      )
                    ],
                  ))),
          Container(
            padding: EdgeInsets.all(15),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _fromAddress = value;
                    });
                  },
                  decoration: InputDecoration(hintText: "请填写您的充值账号", labelText: "充值账号"),
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(hintText: "请填写您的充值账号", labelText: "申请类型"),
                  readOnly: true,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _amount = value;
                    });
                  },
                  decoration: InputDecoration(hintText: "请填写充值金额", labelText: "充值金额"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: OutlinedButton(
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                      onPressed: _getImage,
                      child: Column(
                        children: [
                          Text(
                            "上传凭证",
                            style: TextStyle(color: Colors.white),
                          ),
                          _image != null ? Image.file(_image, width: 50, height: 50) :Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white,
                          )
                        ],
                      )),
                ),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.amber),
                        minimumSize: MaterialStateProperty.all(Size(double.infinity, 40))),
                    onPressed: (_fromAddress == null || _amount == null)
                        ? () {
                            Toast.warm("充值信息不正确");
                          }
                        : () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: Text("请输入资金密码"),
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.lock),
                                          hintText: '请输入资金密码',
                                          labelText: '资金密码',
                                        ),
                                        onChanged: (String value) {
                                          setState(() {
                                            _fundingPass = value;
                                          });
                                        },
                                        obscureText: true,
                                        validator: (String value) {
                                          if (value.isEmpty || value == null) {
                                            return "资金密码不能为空";
                                          }
                                          return null;
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SimpleDialogOption(
                                            onPressed: () {
                                              _deposit();
                                              Navigator.of(context).pop(context);
                                            },
                                            child: Text("确认"),
                                          ),
                                          SimpleDialogOption(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("取消"),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                });
                          },
                    child: Text(
                      "提交审核",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            )),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text("请勿向上述地址充值任何非${widget.asset}资产，否则资产将不"
                "可找回。您充值至上述地址后，需要整个网络节点的确认，12"
                "次网络确认后到账，12次网络确认后可提币。最小充值金额："
                "1${widget.asset},小于最小充值将不会上账且无法退回。您的充"
                "值地址不会经常改变，可以重复充值；如果有改，我们会尽量"
                "通过网站公告或短信通知您。请务必确认电脑及浏览器安全，"
                "防止信息被篡改或漏。"),
          )
        ],
      ),
    );
  }
}
