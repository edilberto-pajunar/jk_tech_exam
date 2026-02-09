class ApiResponse<T> {
  final String? token;
  final bool success;
  final String? message;
  final T? data;
  final dynamic errors;
  final int? statusCode;

  ApiResponse({
    this.token,
    required this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  factory ApiResponse.fromJson(
    dynamic json, {
    T Function(dynamic json)? fromJsonT,
  }) {
    if (json is Map<String, dynamic>) {
      return ApiResponse<T>(
        token: json["token"],
        success: json['success'] ?? false,
        message: json['message'],
        data: fromJsonT != null && json['data'] != null
            ? fromJsonT(json['data'])
            : json['data'],
        errors: json['errors'],
        statusCode: json['status_code'],
      );
    } else {
      return ApiResponse<T>(
        token: json["token"],
        success: true,
        data: fromJsonT != null ? fromJsonT(json) : json,
        statusCode: json['status_code'],
      );
    }
  }
}
