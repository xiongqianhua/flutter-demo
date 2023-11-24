import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Toast.dart';

class NumChangeWidget extends StatefulWidget {
  final double height;
  int num;
  final ValueChanged<int> onValueChanged;

  NumChangeWidget({Key key, this.height = 25.0, this.num = 0, this.onValueChanged})
      : super(key: key);

  @override
  _NumChangeWidgetState createState() {
    return _NumChangeWidgetState();
  }
}

class _NumChangeWidgetState extends State<NumChangeWidget> {
  TextEditingController _numController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _numController =
          TextEditingController.fromValue(TextEditingValue(text: widget.num.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        border: Border.all(color: Colors.blueGrey, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 32.0,
            alignment: Alignment.center,
            child: TextButton(
              style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Text(
                "-",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _minusNum,
            ),
          ),
          Container(
            width: 0.5,
            color: Colors.blueGrey,
          ),
          Container(
            width: 40.0,
            alignment: Alignment.center,
            child: TextField(
              enableInteractiveSelection: false,
              keyboardType: TextInputType.number,
              controller: _numController,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              onChanged: (String value) {
                setState(() {
                  widget.num = NumUtil.getIntByValueStr(value);
                  widget.onValueChanged(NumUtil.getIntByValueStr(widget.num.toString()));
                });
              },
              maxLines: 1,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
          Container(
            width: 0.5,
            color: Colors.blueGrey,
          ),
          Container(
            width: 32.0,
            alignment: Alignment.center,
            child: TextButton(
              style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Text(
                "+",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _addNum,
            ),
          ),
        ],
      ),
    );
  }

  void _minusNum() {
    if (widget.num == 0) {
      return;
    }

    setState(() {
      widget.num -= 1;
      _numController =
          TextEditingController.fromValue(TextEditingValue(text: widget.num.toString()));
      if (widget.onValueChanged != null) {
        widget.onValueChanged(NumUtil.getIntByValueStr(widget.num.toString()));
      }
    });
  }

  void _addNum() {
    setState(() {
      widget.num += 1;
      _numController =
          TextEditingController.fromValue(TextEditingValue(text: widget.num.toString()));
      if (widget.onValueChanged != null) {
        widget.onValueChanged(NumUtil.getIntByValueStr(widget.num.toString()));
      }
    });
  }
}
