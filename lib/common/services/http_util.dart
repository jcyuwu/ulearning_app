import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ulearning_app/common/utils/constants.dart';
import 'package:ulearning_app/features/global.dart';

class HttpUtil {
  late Dio dio;

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: "application/json: charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          print("app request data ${options.data}");
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print("app response data ${response.data}");
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (kDebugMode) {
          print("app error data $e");
        }
        ErrorEntity errorInfo = createErrorEntity(e);
        onError(errorInfo);
      },
    ));
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    var header = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if (accessToken.isNotEmpty) {
      header["Authorization"] = "Bearer $accessToken";
    }
    return header;
  }

  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization!=null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    if (kDebugMode) {
      print("done with post $response");
    }
    return response.data;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message=="") return "Exception";
    return "Exception code $code, $message";
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch(error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timed out");
    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Send timed out");
    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receive timed out");
    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bad SSL certificates");
    case DioExceptionType.badResponse:
      switch(error.response!.statusCode) {
        case 400:
          return ErrorEntity(code: 400, message: "request syntax error");
        case 401:
          return ErrorEntity(code: 401, message: "permission denied");
        default:
          break;
      }
      return ErrorEntity(code: -1, message: "Server bad response");
    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server canceled it");
    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection error");
    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown error");
  }
}

void onError(ErrorEntity eInfo) {
  if (kDebugMode) {
    print("error.code -> ${eInfo.code}, error.message -> ${eInfo.message}");
  }
  switch (eInfo.code) {
    case 400:
      if (kDebugMode) {
        print("Server syntax error");
      }
      break;
    case 401:
      if (kDebugMode) {
        print("You are denied to continue");
      }
      break;
    case 500:
      if (kDebugMode) {
        print("Internal server error");
      }
      break;
    default:
      if (kDebugMode) {
        print("Unknown error");
      }
      break;
  }
}