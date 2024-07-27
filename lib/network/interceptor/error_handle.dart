import 'dart:io';
import 'package:dio/dio.dart';

class ExceptionHandle {
    static const int success = 200;
    static const int success_not_content = 204;
    static const int unauthorized = 401;
    static const int forbidden = 403;
    static const int not_found = 404;

    static const int net_error = 1000;
    static const int parse_error = 1001;
    static const int socket_error = 1002;
    static const int http_error = 1003;
    static const int timeout_error = 1004;
    static const int cancel_error = 1005;
    static const int unknown_error = 9999;

    static NetError handleException(dynamic error) {
        if (error is DioError) {
            if (error.type == DioExceptionType.unknown ||
                error.type == DioExceptionType.badResponse) {
                dynamic e = error.error;
                if (e is SocketException) {
                    return NetError(socket_error, '网络异常，连接失败！');
                }
                if (e is HttpException) {
                    return NetError(http_error, '服务器连接异常！');
                }
                return NetError(net_error, '网络异常，请尝试切换网络！');
            } else if (error.type == DioExceptionType.connectionTimeout ||
                error.type == DioExceptionType.sendTimeout ||
                error.type == DioExceptionType.receiveTimeout) {
                return NetError(timeout_error, '连接超时！');
            } else if (error.type == DioExceptionType.cancel) {
                return NetError(cancel_error, '取消请求');
            } else {
                return NetError(unknown_error, '未知异常');
            }
        } else {
            return NetError(unknown_error, '未知异常');
        }
    }
}

class NetError {
    int code;
    String msg;

    NetError(this.code, this.msg);
}
