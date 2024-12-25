class PaginationApiResponse<T> {
  String? status;
  String? message;
  Payload<T>? payload;
  bool? success;

  PaginationApiResponse({
    this.status,
    this.message,
    this.payload,
    this.success,
  });

  factory PaginationApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return PaginationApiResponse<T>(
      status: json["status"],
      message: json["message"],
      payload: json["payload"] == null ? null : Payload<T>.fromJson(json["payload"], fromJsonT),
      success: json["success"],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      "status": status,
      "message": message,
      "payload": payload?.toJson(toJsonT),
      "success": success,
    };
  }
}

class Payload<T> {
  List<T>? content;
  Pageable? pageable;
  int? totalElements;
  int? totalPages;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  Payload({
    this.content,
    this.pageable,
    this.totalElements,
    this.totalPages,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  factory Payload.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return Payload<T>(
      content: json["content"] == null ? [] : List<T>.from(json["content"]!.map((x) => fromJsonT(x))),
      pageable: json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]),
      totalElements: json["totalElements"],
      totalPages: json["totalPages"],
      last: json["last"],
      size: json["size"],
      number: json["number"],
      sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
      numberOfElements: json["numberOfElements"],
      first: json["first"],
      empty: json["empty"],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      "content": content == null ? [] : List<dynamic>.from(content!.map((x) => toJsonT(x))),
      "pageable": pageable?.toJson(),
      "totalElements": totalElements,
      "totalPages": totalPages,
      "last": last,
      "size": size,
      "number": number,
      "sort": sort?.toJson(),
      "numberOfElements": numberOfElements,
      "first": first,
      "empty": empty,
    };
  }
}


class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? unpaged;
  bool? paged;

  Pageable({
    this.sort,
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.unpaged,
    this.paged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
      offset: json["offset"],
      pageNumber: json["pageNumber"],
      pageSize: json["pageSize"],
      unpaged: json["unpaged"],
      paged: json["paged"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sort": sort?.toJson(),
      "offset": offset,
      "pageNumber": pageNumber,
      "pageSize": pageSize,
      "unpaged": unpaged,
      "paged": paged,
    };
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      empty: json["empty"],
      sorted: json["sorted"],
      unsorted: json["unsorted"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "empty": empty,
      "sorted": sorted,
      "unsorted": unsorted,
    };
  }
}