class Url {
  // test
  // static const String _proApiUrl = "http://47.100.41.138:7002"; // test
  static const String _proApiUrl = "http://139.224.0.103:7002";

  factory Url() {
    final getUrl = Url._internal();
    return getUrl;
  }

  Url._internal();

  static getUrl() {
    return _proApiUrl;
  }

  static bool isDev({status: false}) {
    return status;
  }
}
