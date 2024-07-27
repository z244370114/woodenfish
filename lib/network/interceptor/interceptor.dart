import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import '../../utils/encrypted_utils.dart';
import '../../utils/log_util.dart';
import '../../utils/toast_util.dart';
import '../http_api.dart';

import '../http_utils.dart';
import 'error_handle.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var parameters = options.queryParameters;
    var createSign = EncryptedUtils.createSign(parameters);
    options.headers['Sign'] = createSign;
    options.headers['UserAgent'] = 'mobile';
    options.headers['PackageNames'] = HttpUtils.appInfo;
    super.onRequest(options, handler);
  }
}

class LoggingInterceptor extends Interceptor {
  late DateTime startTime;
  late DateTime endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    startTime = DateTime.now();
    Log.d('---------- Request Start ----------');
    if (options.queryParameters.isEmpty) {
      Log.d('RequestUrl: ${options.baseUrl}${options.path}');
    } else {
      Log.d(
          'RequestUrl: ${options.baseUrl}${options.path}?${Transformer.urlEncodeMap(options.queryParameters)}');
    }
    Log.d('RequestMethod: ${options.method}');
    Log.d('RequestHeaders:${options.headers}');
    Log.d('RequestContentType: ${options.contentType}');
    Log.d('RequestData: ${options.data.toString()}');
    Log.d('---------- Request End ----------');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    RequestOptions options = response.requestOptions;
    Log.d('---------- Response Start ----------');
    Log.d(
        'ResponseUrl: ${options.baseUrl}${options.path}?${Transformer.urlEncodeMap(options.queryParameters)}');
    print(
        'ResponseUrl: ${options.baseUrl}${options.path}?${Transformer.urlEncodeMap(options.queryParameters)}');
    endTime = DateTime.now();
    int duration = endTime.difference(startTime).inMilliseconds;
    if (response.statusCode == ExceptionHandle.success) {
      Log.d('ResponseCode: ${response.statusCode}');
    } else {
      Log.e('ResponseCode: ${response.statusCode}');
    }
    if (ObjectUtil.isNotEmpty(response.data.toString())) {
      var data = json.decode(response.data.toString());
      if (data['err'] == 'Unauthorized' && data['code'] == 401) {
        // LoginState.loginOut();
        return;
      }
    }

    /// 输出结果
    /// Log.json(response.data.toString());
    /// print(response.data.toString());
    Log.d('---------- Response End: $duration 毫秒----------');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.d('----------Error-----------');
    super.onError(err, handler);
  }
}
