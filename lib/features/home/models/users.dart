import '../../../utils/imports.dart';

class Users {
  Users({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });
  late final int page;
  late final int perPage;
  late final int total;
  late final int totalPages;
  late final List<Data> data;
  late final Support support;

  Users.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    support = Support.fromJson(json['support']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['per_page'] = perPage;
    _data['total'] = total;
    _data['total_pages'] = totalPages;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['support'] = support.toJson();
    return _data;
  }
}
