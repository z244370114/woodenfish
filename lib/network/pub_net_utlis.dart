import '/network/http_utils.dart';

import 'http_api.dart';

class PubHttpNetUtils {

  static Future yalieTongJi(Map<String, dynamic> map, bool isList) async {
    return HttpUtils.instance.requestNetWorkAy(Method.get, HttpApi.updateApp,
        queryParameters: map, isList: isList);
  }

  static Future getWellTemplate(Map<String, dynamic> map) async {
    return HttpUtils.instance.requestNetWorkAy(
        Method.get, HttpApi.updateApp,
        queryParameters: map, isList: false);
  }

}
