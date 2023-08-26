import 'package:dio/dio.dart';
import 'package:echo_frontend/app_config.dart';
import 'package:echo_frontend/localization/string_hardcoded.dart';

enum DioMethod {
  get,
  post,
  patch,
  put,
  delete,
}

class NetUtils {
  static NetUtils? _instance;
  late Dio _dio;

  void _init() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, HEAD, POST, PATCH, OPTIONS",
      },
    );
    _dio = Dio(options);
  }

  NetUtils._internal() {
    _instance = this;
    _init();
  }

  factory NetUtils() => _instance ?? NetUtils._internal();

  Future<Map<String, dynamic>> reqeust(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic postData,
    String token = '',
    DioMethod method = DioMethod.get,
  }) async {
    try {
      if (token.isNotEmpty) {
        //_dio.options.headers['Authorization'] = 'Token $token';
        _dio.options.headers['Authorization'] = token;
      }

      Response response;
      switch (method) {
        case DioMethod.get:
          response = await _dio.get(path, queryParameters: queryParameters);
          break;
        case DioMethod.post:
          response = await _dio.post(path, data: postData);
          break;
        case DioMethod.patch:
          response = await _dio.patch(path, data: postData);
          break;
        case DioMethod.put:
          response = await _dio.put(path, data: postData);
          break;
        case DioMethod.delete:
          response = await _dio.delete(path, data: postData);
          break;
        default:
          throw Exception('Unknown DioMethod');
      }

      return response.data;
    } on DioException catch (e) {
      log.e(e.response?.data['message']);

      String errorMessage = e.response?.data['message'] ?? e.message;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = "Connection Timeout".hcd;
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = "Receive Timeout".hcd;
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = "404 server not found ${e.response?.statusCode}".hcd;
          break;
        default:
          errorMessage = e.response?.data['message'] ?? e.message ?? "Unknown Error".hcd;
      }

      return Future.error(errorMessage);
    } catch (error) {
      log.e(error);
      return Future.error(error.toString());
    }
  }
}
