class UserModel {
  UserModel({required this.token});
  late final String token;

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(token: data['token']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
