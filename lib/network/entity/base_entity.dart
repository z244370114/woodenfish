import 'entity_factory.dart';
import 'package:json2dart_safe/json2dart.dart';

class HttpConstant {
  static const String responseCode = 'responseCode';
  static const String responseMsg = 'responseMsg';
  static const String success = 'success';

  static const String result = 'result';

  static const String data = 'data';
  static const String message = 'err';
  static const String code = 'code';
}

class BaseEntity<T> {
  int? code;
  String? message = "";
  T? data;
  int? responseCode;

  String? responseMsg;
  T? result;

  List<T> listData = [];

  BaseEntity(this.code, this.message, this.data, {this.responseCode});

  BaseEntity.fromJson(Map<String, dynamic>? json) {
    if (json!.containsKey(HttpConstant.responseCode)) {
      responseCode = json.asInt(HttpConstant.responseCode);
      responseMsg = json.asString(HttpConstant.responseCode);
    }
    if (json.containsKey(HttpConstant.code)) {
      code = json.asInt(HttpConstant.code);
      message = json.asString(HttpConstant.message);
    }
    if (json.containsKey(HttpConstant.data)) {
      if (json[HttpConstant.data] is List) {
        for (var item in json[HttpConstant.data]) {
          listData.add(_generateOBJ<T>(item)!);
        }
      } else {
        data = _generateOBJ(json[HttpConstant.data]);
      }
    } else if (json.containsKey(HttpConstant.result)) {
      if (json[HttpConstant.result] is List) {
        for (var item in json[HttpConstant.result]) {
          listData.add(_generateOBJ<T>(item)!);
        }
      } else {
        data = _generateOBJ(json[HttpConstant.result]);
      }
    }
  }

  S? _generateOBJ<S>(json) {
    if (S.toString() == 'String') {
      return json.toString() as S;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      if (json != null) {
        return json as S;
      }
      return null;
    } else {
      return EntityFactory.generateOBJ(json);
    }
  }
}
