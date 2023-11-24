import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components/Toast.dart';
import '../main.dart';
import 'UrlUtils.dart';
import 'package:device_info/device_info.dart';

class ResponseData {
  final String code;
  final String message;
  final String date;

  ResponseData(this.code, this.message, this.date);

  ResponseData.fromJson(Map json)
      : code = json['code'],
        message = json['message'],
        date = json['date'];
}

class HttpUtil {
  /// global dio object
  static Dio dio;

  /// global options
  static final String apiPrefix = Url.getUrl();
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 10000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static BaseOptions options = new BaseOptions(
    baseUrl: apiPrefix,
    connectTimeout: CONNECT_TIMEOUT,
    receiveTimeout: RECEIVE_TIMEOUT,
    responseType: ResponseType.json,
  );

  _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print(androidInfo.device);
    // print(androidInfo.type);
    // print(androidInfo.androidId);
    // print(androidInfo.board);
    // print(androidInfo.bootloader);
    // print(androidInfo.brand);
    // print(androidInfo.display);
    // print(androidInfo.fingerprint);
    // print(androidInfo.hardware);
    // print(androidInfo.host);
    // print(androidInfo.id);
    // print(androidInfo.isPhysicalDevice);
    // print(androidInfo.manufacturer);
    // print(androidInfo.model);
    // print(androidInfo.product);
    // print(androidInfo.version);
    return "${androidInfo.manufacturer}-${androidInfo.model}";
  }

  HttpUtil() {
    dio = new Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      _getDeviceInfo();
      print('请求地址：【' + options.method + '  ' + options.baseUrl + options.path + '】');
      print('请求参数：' + options.data.toString());
      print('请求头：' + options.headers.toString());
      return options;
    }, onResponse: (Response response) async {
      print('响应数据：' + response.toString());
      print('响应头 01:' + response.headers.toString());
      print('响应头 02:' + response.request.toString());
      print('响应状态:' + response.statusCode.toString());
      print("相应数据code:" + response.data.toString());
      var res = json.decode(response.toString());
      if (res["status"]["success"] == 0) {
        switch (res["status"]["message"]) {
          case ("ERR_TOKEN_EXPIRED"):
            Global.navigatorKey.currentState.pushNamedAndRemoveUntil("/login", ModalRoute.withName("/"));
            break;
          case ("ERR_INVALID_INVITE_CODE"):
            Toast.warm("邀请码无效");
            break;
          case ("ERR_GET_DEPOSIT_ADDRESS"):
            Toast.warm("地址申请失败");
            break;
          case ("ERR_CREATE_ADDRESS"):
            Toast.warm("地址申请失败");
            break;
          case ("ERR_PHONE_NOT_FOUND"):
            Toast.warm("用户名或密码错误");
            break;
          case ("ERR_INVALID_SMS_CODE"):
            Toast.warm("验证码错误");
            break;
          case ("ERR_SEND_SMS"):
            Toast.warm("验证码发送失败");
            break;
          case ("ERR_TOO_MANY_PENDING_DEPOSIT"):
            Toast.warm("充币请求太多，请稍后重试");
            break;
          case ("ERR_INVALID_PASSWD"):
            Toast.warm("用户名或密码错误");
            break;

          case ("ERR_USER_EXISTED"):
            Toast.warm("用户已注册");
            break;
          case ("ERR_AMOUNT_TOO_LOW"):
            Toast.warm("提币数量太少了");
            break;
          case ("ERR_ORDER_NOT_FOUND"):
            Toast.warm("订单未找到");
            break;

          case ("ERR_FUND_PASSWD"):
            Toast.warm("资金密码错误");
            break;
          case ("ERR_ASSET_NOT_FOUND"):
            Toast.warm("币种不存在");
            break;
          case ("ERR_NO_SUCH_USER"):
            Toast.warm("用户不存在");
            break;
          case ("ERR_BAD_PARAMS"):
            Toast.warm("参数错误");
            break;
          case ("ERR_ADDRESS_NOT_FOUND"):
            Toast.warm("地址不存在");
            break;
          case ("ERR_INVALID_AMOUNT"):
            Toast.warm("数量不正确");
            break;
          case ("ERR_INSUFFICIENT_FUND"):
            Toast.warm("余额不足");
            break;
          case ("ERR_WITHDRAWAL"):
            Toast.warm("提币失败");
            break;
          case ("ERR_INVALID_ADDRESS"):
            Toast.warm("地址格式未知");
            break;
          case ("ERR_INSUFFICIENT_AMOUNT"):
            Toast.warm("库存不足");
            break;
          case ("ERR_SMS_TOO_FAST"):
            Toast.warm("请求太快了，请稍后再试");
            break;
          case ("ERR_WITHDRAWAL_NOT_FOUND"):
            Toast.warm("记录不存在");
            break;
          case ("ERR_NO_FILE_FOUND"):
            Toast.warm("文件未找到");
            break;
          case ("ERR_UPLOAD_IMG"):
            Toast.warm("图片上传失败");
            break;
          case ("ERR_AMOUNT_NOT_ENOUGH"):
            Toast.warm("数量不足，质押失败");
            break;
          case ("ERR_INVALID_ASSET"):
            Toast.warm("不支持的币种");
            break;
          case ("ERR_SYSTEM_CONFIG"):
            Toast.warm("系统配置错误");
            break;
          case ("ERR_TOO_MANY_PENDING_DEPOSIT"):
            Toast.warm("多笔充值在进行中");
            break;
          case ("ERR_TOO_MANY_PENDING_WITHDRAW"):
            Toast.warm("多笔提币在进行中");
            break;
          case ("ERR_WITHDRAW_DISABLED"):
            Toast.warm("提币暂停");
            break;
          case ("ERR_PRODUCT_NOT_START"):
            Toast.warm("产品还未开始");
            break;
          case ("ERR_AMOUNT_TOO_HIGH"):
            Toast.warm("数量太多了");
            break;
            
          default:
            throw new DioError(error: res);
            break;
        }
      }
      return response;
    }, onError: (DioError err) {
      print(err.type.index);
      switch (err.type.index) {
        case (0):
          Toast.fail("网络超时");
          break;
        case (3):
          Toast.fail("请求错误");
          break;
        default:
          Toast.warm("网络错误");
          print("default:" + err.message.toString());
          break;
      }
    }));
  }

  /// request method
  request(String url, {data, method, bool upload = false}) async {
    data = data ?? {};
    method = method ?? 'GET';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userToken = sharedPreferences.getString("userToken");
    dio.options.headers["x-agent"] = await _getDeviceInfo();
    if (userToken == null) {
    } else {
      dio.options.headers["x-access-token"] = userToken;
    }
    if (upload) {
      print("content_type should be 'multipart/form-data'");
    } else {
      dio.options.contentType = "application/json";
    }

    Response response = await dio.request(url, data: data, options: new Options(method: method));
    return response;
  }
}
