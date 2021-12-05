class AuthUserModel {
  String? userName;
  String? password;
  String? avatarUrl;

  AuthUserModel({
    this.userName,
    this.password,
    this.avatarUrl,
  });

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    password = json['password'];
    avatarUrl = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_name'] = userName;
    data['password'] = password;
    data['avatar'] = avatarUrl;
    return data;
  }

  AuthUserModel copyWith(AuthUserModel newUser) {
    return AuthUserModel(
      userName: newUser.userName ?? userName,
      avatarUrl: newUser.avatarUrl ?? avatarUrl,
      password: newUser.password ?? password,
    );
  }
}
