import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../common/application.dart';
import '../common/c_key.dart';
import '../utils/log_util.dart';
import 'entity/base_entity.dart';
import 'http_api.dart';
import 'interceptor/error_handle.dart';
import 'interceptor/interceptor.dart';

class HttpUtils {
  static final HttpUtils _singleton = HttpUtils._internal();

  static HttpUtils get instance => HttpUtils();

  ///baseUrl地址
  static String _apiBaseUrl = HttpApi.baseUrl;

  ///是否开启代理
  static bool _proxy = false;

  ///ip代理地址
  static String? _proxyip = '';

  ///应用token
  static String? _token = Application.getStorage.read(CKey.loginToken);

  static String? get token => _token;

  static const String? _appInfo = '';

  static String? get appInfo => _appInfo;

  static set token(String? value) {
    if (_token != value) {
      _token = value;
      if (_token == null) {
        Application.getStorage.remove(CKey.loginToken);
      } else {
        Application.getStorage.write(CKey.loginToken, _token);
      }
    }
  }

  static init(
      {required String baseurl,
      String? customhost,
      bool proxy = false,
      String? proxyip}) async {
    _apiBaseUrl = baseurl;
    _proxy = proxy;
    _proxyip = proxyip;
    _token = Application.getStorage.read(CKey.loginToken);
  }

  factory HttpUtils() {
    return _singleton;
  }

  static late Dio _dio;

  Dio getDio() {
    return _dio;
  }

  HttpUtils._internal() {
    var options = BaseOptions(
      baseUrl: _apiBaseUrl,
      connectTimeout: const Duration(milliseconds:  10 * 1000),
      receiveTimeout: const Duration(milliseconds:  10 * 1000),
      sendTimeout: const Duration(milliseconds:  10 * 1000),
      contentType: ContentType.json.value,
      responseType: ResponseType.plain,
      validateStatus: (status) {
        /// 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
    );
    _dio = Dio(options);

    ///统一请求头拦截器
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LoggingInterceptor());

    if (_proxy && _proxyip != null && _proxyip!.isNotEmpty) {
      ///设置代理用来调试应用

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (_) {
          return 'PROXY $_proxyip';
        };

        ///抓Https包设置
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _request<T>(String method, String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      String? baseUrl,
      CancelToken? cancelToken,
      Options? options}) async {
    if (baseUrl != null && baseUrl.startsWith("http")) {
      _dio.options.baseUrl = baseUrl;
    } else {
      _dio.options.baseUrl = _apiBaseUrl;
    }

    Response response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    try {
      Map<String, dynamic> _map = parseData(response.data.toString());
      _map[HttpConstant.responseCode] = response.statusCode;
      _map[HttpConstant.responseMsg] = response.statusMessage ?? "";

      return BaseEntity.fromJson(_map);
    } catch (e) {
      print(e);
      if (e is TypeError) {
        print(e.stackTrace);
      }
      return BaseEntity(ExceptionHandle.parse_error, '数据解析错误', null);
    }
  }

  Future requestNetWorkAy<T>(Method method, String url,
      {String? baseUrl,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isList = false,
      CancelToken? cancelToken,
      Options? options}) async {
    String m = _getMethod(method);
    return await _request<T>(m, url,
            data: data,
            queryParameters: queryParameters,
            options: options,
            baseUrl: baseUrl,
            cancelToken: cancelToken)
        .then((result) {
      if (result.code == 200) {
        if (isList) {
          return result.listData;
        } else {
          return result.data;
        }
      } else {
        if (result.code != null) {
          _onError(result.code, result.message ?? "", null);
        } else {
          _onError(result.responseCode, result.responseMsg ?? "", null);
        }
        return result.data;
      }
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      if (e is DioError) {
        CancelToken.isCancel(e);
      }
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, null);
    });
  }

  Options _checkOptions(method, options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  Future requestNetwork<T>(Method method, String url,
      {Function(T? t)? onSuccess,
      Function(List<T> list)? onSuccessList,
      Function(int code, String msg)? onError,
      String? baseUrl,
      dynamic params,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      Options? options,
      bool isResult = false,
      bool isList = false}) {
    String m = _getMethod(method);
    return _request<T>(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            baseUrl: baseUrl,
            cancelToken: cancelToken)
        .then((BaseEntity<T>? result) {
      if (result!.code == 200) {
        if (!isResult) {
          if (isList) {
            if (onSuccessList != null) {
              onSuccessList(result.listData);
            }
          } else {
            if (onSuccess != null) {
              onSuccess(result.data);
            }
          }
        }
      } else {
        if (result.code != null) {
          _onError(result.code, result.message ?? "", onError);
        } else {
          _onError(result.responseCode, result.responseMsg ?? "", onError);
        }
      }
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      if (e is DioError) {
        CancelToken.isCancel(e);
      }
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  // Future<BaseEntity> download(
  //   String urlPath,
  //   savePath, {
  //   ProgressCallback? onReceiveProgress,
  //   Map<String, dynamic>? queryParameters,
  //   data,
  // }) async {
  //   final filePath = await getApplicationDocumentsDirectory();
  //   var file = Directory(filePath.path + "/" + savePath);
  //   try {
  //     bool exists = await file.exists();
  //     if (!exists) {
  //       await file.create();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   Response response = await _dio.download(urlPath, savePath,
  //       onReceiveProgress: onReceiveProgress, queryParameters: queryParameters);
  //   try {
  //     Map<String, dynamic> _map = parseData(response.data.toString());
  //     _map[HttpConstant.responseCode] = response.statusCode;
  //     _map[HttpConstant.responseMsg] = response.statusMessage ?? "";
  //     return BaseEntity.fromJson(_map);
  //   } catch (e) {
  //     print(e);
  //     if (e is TypeError) {
  //       print(e.stackTrace);
  //     }
  //     return BaseEntity(ExceptionHandle.parse_error, '数据解析错误', null);
  //   }
  // }

  _cancelLogPrint(e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.e('取消请求接口： $url');
    }
  }

  _onError(int? code, String msg, Function(int code, String mag)? onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    }
    if (onError != null) {
      onError(code, msg);
    }
    Log.e('接口请求异常： code: $code, mag: $msg');
    // ToastUtil.showToast(msg);
  }

  String _getMethod(Method method) {
    String m;
    switch (method) {
      case Method.get:
        m = 'GET';
        break;
      case Method.post:
        m = 'POST';
        break;
      case Method.put:
        m = 'PUT';
        break;
      case Method.patch:
        m = 'PATCH';
        break;
      case Method.delete:
        m = 'DELETE';
        break;
      case Method.head:
        m = 'HEAD';
        break;
    }
    return m;
  }
}

Map<String, dynamic> parseData(String data) {
  Map<String, dynamic> result = {};
  try {
    result = json.decode(data);
  } catch (e) {
    print(e);
  }
  return result;
}

enum Method { get, post, put, patch, delete, head }
