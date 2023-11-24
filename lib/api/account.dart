import '../utils/HttpUtil.dart';

class AccountRequest {

  static Future validateCode(data) async {
    return await HttpUtil()
        .request("/account/code/open", data: data, method: "POST");
  }

  static Future validateLoginCode(data) async {
    return await HttpUtil()
        .request("/account/code", data: data, method: "POST");
  }

  static Future signup(data) async {
    return await HttpUtil()
        .request("/account/signup", data: data, method: "POST");
  }

  static Future signin(data) async {
    return await HttpUtil()
        .request("/account/signin", data: data, method: "POST");
  }

  static Future smssignin(data) async {
    return await HttpUtil()
        .request("/account/sms/signin", data: data, method: "POST");
  }

  static Future getUserInfo() async {
    return await HttpUtil().request("/account/info", method: "GET");
  }

  static Future kyc(data) async {
    return await HttpUtil().request("/user/nickname", data: data, method: "PUT");
  }

  static Future levelConfig(asset) async {
    return await HttpUtil().request("/account/level/config?asset=$asset", method: "GET");
  }

  static Future getKycInfo() async {
    return await HttpUtil().request("/account/kyc", method: "GET");
  }

  static Future getUserInfoByID(id) async {
    return await HttpUtil().request("/v1/user/$id", method: "GET");
  }

  static Future password(data) async {
    return await HttpUtil()
        .request("/account/passwd/login/recover", data: data, method: "POST");
  }

  static Future fund_password(data) async {
    return await HttpUtil()
        .request("/account/passwd/fund", data: data, method: "POST");
  }

  static Future balances() async {
    return await HttpUtil().request("/account/balances", method: "GET");
  }

  static Future mining_info({category="MINER"}) async {
    return await HttpUtil().request("/account/mining/list?category=${category}", method: "GET");
  }

  static Future reward_overview() async {
    return await HttpUtil().request("/fund/reward/overview", method: "GET");
  }

  static Future invitation(page,size) async {
    return await HttpUtil().request("/account/invitations?page=$page&size=$size", method: "GET");
  }
}
