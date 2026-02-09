import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jk_tech_exam/client/model/api_endpoints.dart';
import 'package:jk_tech_exam/client/model/api_exceptions.dart';
import 'package:jk_tech_exam/client/model/api_response.dart';
// import 'package:go_gym/client/model/api_interceptors.dart';

abstract class ApiClient {
  final Dio _dio;
  final Map<String, CancelToken> _cancelTokens = {};
  // final SharedPreferencesStorage _storage;

  ApiClient({
    required Dio dio,
    // required SharedPreferencesStorage storage,
  }) : _dio = dio,
       // _storage = storage,
       super() {
    dio.options = BaseOptions(
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    // dio.interceptors.add(ApiInterceptors());
  }

  /// Cancel a specific request by its key
  void cancelRequest(String key) {
    log("Cancelling request: $key");
    _cancelTokens[key]?.cancel('Request cancelled');
    _cancelTokens.remove(key);
    log("Request cancelled: $key");
  }

  /// Cancel all ongoing requests
  void cancelAllRequests() {
    _cancelTokens.forEach((key, token) {
      token.cancel('All requests cancelled');
    });
    _cancelTokens.clear();
  }

  /// Get or create a cancel token for a request
  CancelToken _getCancelToken(String key) {
    if (!_cancelTokens.containsKey(key)) {
      _cancelTokens[key] = CancelToken();
    }
    return _cancelTokens[key]!;
  }

  Options options(String? token) => Options(
    headers: token == null
        ? {
            "Content-Type": "application/json",
            "x-api-key": dotenv.env['REQRES_API_KEY'],
          }
        : {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
  );

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    String? secretKey,
    String? cancelKey,
  }) async {
    try {
      // final token = secretKey ?? await _authRepository.getFirebaseToken();

      final cancelToken = cancelKey != null ? _getCancelToken(cancelKey) : null;

      final response = await _dio.get<T>(
        "${baseUrl ?? ApiEndpoints.baseUrl}$path",
        queryParameters: queryParameters,
        options: options ?? this.options(null),
        cancelToken: cancelToken,
      );
      return ApiResponse<T>.fromJson(
        response.data,
        fromJsonT: (json) => json as T,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw ApiExceptions(
          "Request cancelled",
          statusCode: e.response?.statusCode,
        );
      }
      throw ApiExceptions.fromDioError(e);
    } catch (e) {
      throw ApiExceptions("Unknown error occured", statusCode: 500);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    String? secretKey,
    bool isJson = true,
    String? cancelKey,
  }) async {
    try {
      // final token = secretKey ?? await _authRepository.getFirebaseToken();
      final cancelToken = cancelKey != null ? _getCancelToken(cancelKey) : null;

      final response = await _dio.post<T>(
        "${baseUrl ?? ApiEndpoints.baseUrl}$path",
        data: isJson ? jsonEncode(data) : data,
        queryParameters: queryParameters,
        options: options ?? this.options(null),
        cancelToken: cancelToken,
      );
      return ApiResponse<T>.fromJson(
        response.data,
        fromJsonT: (json) => json as T,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw ApiExceptions(
          "Request cancelled",
          statusCode: e.response?.statusCode,
        );
      }
      throw ApiExceptions.fromDioError(e);
    } catch (e) {
      throw ApiExceptions('Unknown error occurred', statusCode: 500);
    }
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    String? secretKey,
    bool isJson = true,
  }) async {
    try {
      // final token = secretKey ?? await _authRepository.getFirebaseToken();

      final response = await _dio.put<T>(
        "${baseUrl ?? ApiEndpoints.baseUrl}$path",
        data: isJson ? jsonEncode(data) : data,
        queryParameters: queryParameters,
        options: options ?? this.options(null),
      );
      return ApiResponse<T>.fromJson(
        response.data,
        fromJsonT: (json) => json as T,
      );
    } on DioException catch (e) {
      throw ApiExceptions.fromDioError(e);
    } catch (e) {
      throw ApiExceptions('Unknown error occurred: $e');
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    String? secretKey,
  }) async {
    try {
      // final token = secretKey ?? await _authRepository.getFirebaseToken();

      final response = await _dio.delete<T>(
        "${baseUrl ?? ApiEndpoints.baseUrl}$path",
        data: data,
        queryParameters: queryParameters,
        options: options ?? this.options(null),
      );
      return ApiResponse<T>.fromJson(
        response.data,
        fromJsonT: (json) => json as T,
      );
    } on DioException catch (e) {
      throw ApiExceptions.fromDioError(e);
    } catch (e) {
      throw ApiExceptions('Unknown error occurred');
    }
  }

  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
    String? secretKey,
  }) async {
    try {
      // final token = secretKey ?? await _authRepository.getFirebaseToken();

      final response = await _dio.patch<T>(
        "${baseUrl ?? ApiEndpoints.baseUrl}$path",
        data: data,
        queryParameters: queryParameters,
        options: options ?? this.options(null),
      );
      return ApiResponse<T>.fromJson(
        response.data,
        fromJsonT: (json) => json as T,
      );
    } on DioException catch (e) {
      throw ApiExceptions.fromDioError(e);
    } catch (e) {
      throw ApiExceptions('Unknown error occurred');
    }
  }

  // Future<File> downloadFile(
  //   String url, {
  //   String? savePath,
  //   ProgressCallback? onReceiveProgress,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  // }) async {
  //   try {
  //     final savedPath = savePath ?? await _getLocalFilePath(url);
  //     final response = await _dio.download(
  //       url,
  //       savedPath,
  //       onReceiveProgress: onReceiveProgress,
  //       queryParameters: queryParameters,
  //       options: options,
  //     );

  //     if (response.statusCode == 200) {
  //       return File(savedPath);
  //     } else {
  //       throw ApiExceptions('Failed to download file: ${response.statusMessage}');
  //     }
  //   } on DioException catch (e) {
  //     throw ApiExceptions.fromDioError(e);
  //   } catch (e) {
  //     throw ApiExceptions('Unknown error occurred during download');
  //   }
  // }

  Future<ApiResponse<T>> uploadFile<T>(
    String path, {
    required File file,
    String? fileKey,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        ...?data,
        fileKey ?? 'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      final response = await _dio.post<T>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiExceptions.fromDioError(e);
    } catch (e) {
      throw ApiExceptions('Unknown error occurred during upload');
    }
  }

  Future<ApiResponse<T>> uploadFiles<T>(
    String path, {
    required List<File> files,
    String? filesKey,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?data,
        filesKey ?? 'files': files.map((file) {
          final fileName = file.path.split('/').last;
          return MultipartFile.fromFileSync(file.path, filename: fileName);
        }).toList(),
      });

      final response = await _dio.post<T>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiExceptions.fromDioError(e);
    } catch (e) {
      throw ApiExceptions('Unknown error occurred during multi-file upload');
    }
  }

  /// Helper method to get local file path for downloads
  // Future<String> _getLocalFilePath(String url) async {
  //   final directory = await getTemporaryDirectory();
  //   final fileName = url.split('/').last;
  //   return '${directory.path}/$fileName';
  // }
}
