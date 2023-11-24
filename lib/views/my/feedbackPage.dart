import 'package:cy_app/api/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/Toast.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String _content = "";

  _commitFeedback() async {
    var result = await AppRequest.feedback({"content": _content});
    if (result.data["status"]["success"] == 1) {
      Toast.success("已提交反馈");
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "用户反馈",
        ),
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              minLines: 5,
              maxLines: 10,
              maxLength: 200,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              onChanged: (value) {
                setState(() {
                  _content = value;
                });
              },
              decoration: InputDecoration(
                  hintText: "请输入您的反馈内容，我们会尽快处理您的反馈。",
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            width: double.infinity,
            height: 40,
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                child: Text(
                  "确认提交",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: _content == "" ? null : _commitFeedback),
          )
        ],
      ),
    );
  }
}
