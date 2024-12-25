class GenericListResponse<T> {
  String? status;
  String? message;
  List<T>? payload;
  bool? success;

  GenericListResponse({this.status, this.message, this.payload, this.success});

  GenericListResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    status = json['status'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <T>[];
      json['payload'].forEach((v) {
        payload!.add(fromJsonT(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => toJsonT(v)).toList();
    }
    data['success'] = this.success;
    return data;
  }
}
