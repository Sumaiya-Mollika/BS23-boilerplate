import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/generic response/common_response.dart';
import '../models/generic response/error_response.dart';
import '../utils/constants.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient apiClient = ApiClient._internal();
  late Dio _dio;

  ApiClient._internal() {
    var options = BaseOptions(
      baseUrl: "",
    );
    _dio = Dio(options);
  }

  void postRequest(String url, Map<String, dynamic>? request,
      ResponseCallback<dynamic, String?> callback,
      {bool checkStatusCodeOnly = false, Map<String, dynamic>? param}) async {
    try {
      final apiResponse =
          await client.post(url, data: request, queryParameters: param);
      final responseData = apiResponse.data;

      if (responseData is Map<String, dynamic> || responseData is List) {
        if (checkStatusCodeOnly) {
          callback(responseData, null);
        } else {
          _getActualResponse(
              responseData, (response, error) => callback(response, error));
        }
      } else {
        log("apiResponse.toString()");
        log(apiResponse.toString());
        callback(null, _getErrorMessage(apiResponse));
      }
    } on DioException catch (e) {
      log("getDioErrorResponse.toString()");
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, e.toString());
    }
  }

  void putRequest(String url, Map<String, dynamic> request,
      ResponseCallback<dynamic, String?> callback,
      {bool checkStatusCodeOnly = false}) async {
    try {
      final apiResponse = await client.put(url, data: request);
      final responseData = apiResponse.data;

      if (responseData is Map<String, dynamic> || responseData is List) {
        if (checkStatusCodeOnly) {
          callback(responseData, null);
        } else {
          _getActualResponse(
              responseData, (response, error) => callback(response, error));
        }
      } else {
        callback(null, _getErrorMessage(apiResponse));
      }
    } on DioException catch (e) {
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, e.toString());
    }
  }

  void deleteRequest(String url, ResponseCallback<dynamic, String?> callback,
      {bool checkStatusCodeOnly = false}) async {
    try {
      final apiResponse = await client.delete(url);
      final responseData = apiResponse.data;

      if (responseData is Map<String, dynamic> || responseData is List) {
        if (checkStatusCodeOnly) {
          callback(responseData, null);
        } else {
          _getActualResponse(
              responseData, (response, error) => callback(response, error));
        }
      } else {
        callback(null, _getErrorMessage(apiResponse));
      }
    } on DioException catch (e) {
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, e.toString());
    }
  }

  void getRequest(
    String url,
    Map<String, dynamic>? queryParameters,
    ResponseCallback<dynamic, String?> callback, {
    bool checkStatusCodeOnly = false,
  }) async {
    try {
      final apiResponse = await client.get(
        url,
        queryParameters: queryParameters,
      );

      var responseData = apiResponse.data;
      if (apiResponse.statusCode == 200) {
        callback(responseData, null);
      } else if (apiResponse.statusCode == 201) {
        callback(responseData, null);
      } else if (apiResponse.statusCode == 204) {
        callback(null, "$responseData");
      } else {
        callback(null, "$responseData");
      }
    } on DioException catch (e) {
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, "$e");
    }
  }

  void _getActualResponse(
      dynamic response, Function(dynamic, String?) callback) {
    if (response['success'] == true) {
      callback(response, null);
    } else {
      callback(null, response['message']);
    }
  }

  String _getErrorMessage(Response<dynamic> apiResponse) {
    var responseData = apiResponse.data;

    if (responseData != null && responseData != "") {
      String errorText = "";
      var errors = "${apiResponse.data}".split("\n");

      for (int i = 0; i < errors.length; i++) {
        if (i < 12) errorText += errors[i];
      }

      return errorText;
    } else {
      return "${apiResponse.statusMessage}";
    }
  }

  String? _getDioErrorResponse(DioException e) {
    var response = e.response;
    var statusCode = response?.statusCode;

    if (response?.data != null) {
      try {
        if (statusCode != null && statusCode == 401 ||
            statusCode == 403 ||
            statusCode! >= 500) {
          if (statusCode! >= 500) {
            return "Internal Server Error: $statusCode";
          } else {
            ErrorResponse errorResponse =
                ErrorResponse.fromJson(json.decode(response!.data));

            var message = errorResponse.message;

            return message != null && message.isNotEmpty
                ? message
                : errorResponse.message;
          }
        } else {
          CommonResponse commonResponse =
              CommonResponse.fromJson(response?.data);

          return commonResponse.message;
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return e.message;
    }
  }

  Dio get client {
    _dio.interceptors.clear();
    _dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.none) {
            return handler.reject(
                DioException(
                    requestOptions: options,
                    error: "internet_connectivity_problem"),
                true);
          }

          if (isJwtTokenNeeded(options.path)) {
            var token = await storage.read(key: StorageKeys.keyJwtToken);
            options.headers.addAll({
              "Authorization": "Bearer $token",
            });
          }
        } catch (e) {
          return handler.reject(
              DioException(
                  requestOptions: options, error: "Error: ${e.toString()}"),
              true);
        }

        options.headers.addAll(
          {"Content-type": "application/json"},
        );
        return handler.next(options);
      },
      onError: (error, handler) async {
        return handler.next(error);
      },
    ));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        logPrint: (object) {
          log(object.toString());
        },
      ));
    }

    return _dio;
  }

  bool isJwtTokenNeeded(String path) {
    return true;
  }
}

extension _AsOptions on RequestOptions {
  Options asOptions() {
    return Options(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      extra: extra,
      headers: headers,
      responseType: responseType,
      contentType: contentType,
      validateStatus: validateStatus,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      listFormat: listFormat,
    );
  }
}
