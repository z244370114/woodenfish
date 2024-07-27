import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptedUtils {
  static String createSign(Map<String, dynamic> parameters) {
    var values = parameters.values.map((e) => e.toString()).toList();
    values.sort();
    String result = values.join(",");
    var bytes = utf8.encode(result);
    var md5Hash = md5.convert(bytes);
    return md5Hash.toString();
  }
}
