import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final int total;
  final int page;
  final int limit;
  final int pages;

  const PaginationEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.pages,
  });

  @override
  List<Object?> get props => [total, page, limit, pages];

  factory PaginationEntity.fromJson(Map<String, dynamic> json) {
    return PaginationEntity(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      pages: json['pages'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'page': page,
      'limit': limit,
      'pages': pages,
    };
  }
}