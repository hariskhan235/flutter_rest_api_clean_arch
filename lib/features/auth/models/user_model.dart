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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          token == other.token;

  @override
  int get hashCode => token.hashCode;
}
