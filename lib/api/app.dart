import '../utils/HttpUtil.dart';

class AppRequest {
  static Future version() async {
    return await HttpUtil().request("/app/version?platform=android");
  }

  static Future banner() async {
    return await HttpUtil().request("/app/banners", method: "GET");
  }

  static Future announcement(category,page, size) async {
    return await HttpUtil().request("/announcement/list?category=${category}&page=$page&size=$size", method: "GET");
  }

  static Future news(page, size) async {
    return await HttpUtil().request("/news/list?page=$page&size=$size", method: "GET");
  }

  static Future newsDetail(id) async {
    return await HttpUtil().request("/news/detail?id=${id}", method: "GET");
  }

  static Future feedback(data) async {
    return await HttpUtil().request("/app/feedback", data: data, method: "POST");
  }
}
