class GenericApiResponse<T> {
  String? status;
  String? message;
  T? payload;
  bool? success;

  GenericApiResponse({this.status, this.message, this.payload, this.success});

  factory GenericApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonPayload) {
    return GenericApiResponse<T>(
      status: json['status'],
      message: json['message'],
      payload: json['payload'] != null ? fromJsonPayload(json['payload']) : null,
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'status': status,
      'message': message,
      'success': success,
    };
    if (payload != null) {
      data['payload'] = (payload as dynamic).toJson();
    }
    return data;
  }
}