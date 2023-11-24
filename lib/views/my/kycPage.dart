import 'package:cy_app/components/Toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/account.dart';

class KycPage extends StatefulWidget {
  @override
  _KycPageState createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
  final GlobalKey<FormState> _kycForm = GlobalKey<FormState>();
  String _userRealName = "";
  String _phone = "";
  String _licenseNum = "";
  TextEditingController _phoneController;
  TextEditingController _userRealNameController;
  TextEditingController _licenseNumController;

  FocusNode _usernameTextBoxFocus = FocusNode();
  FocusNode _licenseNumTextBoxFocus = FocusNode();

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var kycInfo = await AccountRequest.getKycInfo();
    setState(() {
      _phone = prefs.getString("phone");
    });
    if (kycInfo.data["status"]["success"] == 1 && kycInfo.data["result"] is Map) {
      setState(() {
        _userRealName = kycInfo.data["result"]["name"];
        _licenseNum = kycInfo.data["result"]["id_number"];
      });
    }
    setState(() {
      _phoneController = TextEditingController.fromValue(TextEditingValue(text: _phone));
      _userRealNameController = TextEditingController.fromValue(TextEditingValue(text: _userRealName));
      _licenseNumController = TextEditingController.fromValue(TextEditingValue(text: _licenseNum));
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _kyc() async {
    if (_kycForm.currentState.validate()) {
      _kycForm.currentState.save();
      var result = await AccountRequest.kyc({
        "nickname": _userRealName,
      });
      if (result.data["status"]["success"] == 1) {
        Toast.success("设置成功");
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("设置昵称"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                    key: _kycForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                focusNode: _usernameTextBoxFocus,
                                keyboardType: TextInputType.text,
                                controller: _userRealNameController,
                                decoration: const InputDecoration(
                                    hintText: '请输入昵称', prefix: Text('昵称        '), labelText: "昵称"),
                                onChanged: (String value) {
                                  setState(() {
                                    _userRealName = value;
                                  });
                                },
                                validator: (String value) {
                                  if (value.isEmpty || value == null) {
                                    return "昵称不能为空";
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                width: double.infinity,
                                height: 45.0,
                                child: TextButton(
                                    child: Text(
                                      "保存",
                                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                                    ),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                                    onPressed: () async {
                                      if (_kycForm.currentState.validate()) {
                                        if (await _kyc()) {
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    )))
          ],
        ));
  }
}
