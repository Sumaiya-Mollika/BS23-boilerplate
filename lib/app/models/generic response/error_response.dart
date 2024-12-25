class ErrorResponse {
  final bool? success;
  final String? message;
  final dynamic payload;
  final String? status;

  ErrorResponse({
    this.success,
    this.message,
    this.payload,
    this.status,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        payload = json['payload'],
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'payload': payload,
        'status': status
      };
}
