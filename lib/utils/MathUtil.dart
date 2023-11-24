import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';

String minusUtil(dynamic one, dynamic two) {
  if (one == null) {
    one = 0;
  }
  if (two == null) {
    two = 0;
  }
  return NumUtil.subtract(one, two).toString();
}

String plusUtil(dynamic one, dynamic two) {
  if (one == null) {
    one = 0;
  }
  if (two == null) {
    two = 0;
  }
  return NumUtil.add(one, two).toString();
}
