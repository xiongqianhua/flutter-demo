import 'package:cy_app/api/product.dart';
import 'package:cy_app/components/ProductWidget.dart';
import 'package:cy_app/components/Toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListPage extends StatefulWidget {
  final category;

  const ProductListPage({Key key, this.category}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>
    with AutomaticKeepAliveClientMixin {
  List _productList = [];
  dynamic _balance = 0;
  int _page = 0;
  String _userRole;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString("user_role");
    });
  }

  _getProductList() async {
    var result = await ProductRequest.productList(widget.category, _page, 5);
    if (result.data["status"]["success"] == 1) {
      setState(() {
        _productList = result.data["result"]["data"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _popCount = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
        child: RefreshIndicator(
            onRefresh: () async {
              await _getProductList();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _productList.length == 0
                    ? Center(
                        child: Text("暂无产品"),
                        heightFactor: 4,
                      )
                    : ProductWidget(
                        productList: _productList,
                      ),
              ],
            )),
        onWillPop: () async {
          if (_popCount < 1) {
            Toast.success("再来一次退出");
            setState(() {
              _popCount++;
            });
            return Future.value(false);
          } else {
            return true;
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
