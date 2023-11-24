import '../utils/HttpUtil.dart';

class FundRequest {
  static Future address(data) {
    return HttpUtil().request("/fund/book/address", data: data, method: "POST");
  }

  static Future addressList(page, size) {
    return HttpUtil().request("/fund/book/address?page=$page&size=$size", method: "GET");
  }

  static Future modifyAddress(id, data) {
    return HttpUtil().request("/fund/book/address?id=$id", data: data, method: "POST");
  }

  static Future deleteAddress(id) {
    return HttpUtil().request("/fund/book/address?id=$id", method: "DELETE");
  }

  static Future deposit(asset) {
    return HttpUtil().request("/fund/deposit/address?asset=${asset}", method: "GET");
  }

  static Future withdraw(data) {
    return HttpUtil().request("/fund/withdraw", data: data, method: "POST");
  }

  static Future transfer(data) {
    return HttpUtil().request("/fund/transfer/inner", data: data, method: "POST");
  }

  static Future doDeposit(data) {
    return HttpUtil().request("/fund/deposit", data: data, method: "POST", upload: true);
  }

  static Future cancelWithdraw(wid) {
    return HttpUtil().request("/fund/withdrawal?wid=${wid}", method: "PUT");
  }

  static Future record(page, size, {category = "", asset = ""}) {
    return HttpUtil().request("/fund/record?category=$category&asset=$asset&page=$page&size=$size", method: "GET");
  }

  static Future staked(page, size, {order_id = 0}) {
    String url = "/product/order/staked?order_id=$order_id&page=$page&size=$size";
    if (order_id == 0) {
      url = "/product/order/staked?order_id=&page=$page&size=$size";
    }
    return HttpUtil().request(url, method: "GET");
  }

  static Future profit(page, size) {
    return HttpUtil().request("/fund/profit/record?page=$page&size=$size", method: "GET");
  }

  static Future recordDetail(id) {
    return HttpUtil().request("/fund/withdrawal/$id", method: "GET");
  }

  static Future config(asset) {
    return HttpUtil().request("/fund/asset/config?asset=$asset", method: "GET");
  }

  static Future assetList() {
    return HttpUtil().request("/fund/asset/list", method: "GET");
  }

  static Future groupRecordList(page,size,{category=""}) {
    return HttpUtil().request("/fund/reward/group?page=$page&size=$size&category=$category", method: "GET");
  }
}
