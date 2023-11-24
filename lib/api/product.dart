import '../utils/HttpUtil.dart';

class ProductRequest {
  static Future productList(category, page, size) async {
    String url = '/product/list?category';
    if (category == 'CLUSTER') {
      url = '/product/list?product_category';
    }
    return await HttpUtil()
        .request("${url}=$category&page=$page&size=$size");
  }

  static Future hotProductList(category) async {
    String url = '/product/hot?category';
    if (category == 'CLUSTER') {
      url = '/product/hot?product_category';
    }
    return await HttpUtil().request("${url}=$category");
  }

  static Future productDetail(pid) async {
    return await HttpUtil()
        .request("/product/detail?pid=${pid}", method: "GET");
  }

  static Future productBuy(data) async {
    return await HttpUtil().request("/product/buy", data: data, method: "POST");
  }

  static Future productOrder(page, size) async {
    return await HttpUtil().request("/product/order?page=$page&size=$size");
  }

  static Future staking(data) async {
    return await HttpUtil()
        .request("/product/order/stake", data: data, method: "POST");
  }

  static Future getMoreProductivityData(offset) async {
    return await HttpUtil().request(
        "/v1/capacity?offset=$offset&limit=20&order=desc&sortby=created_at");
  }
}
