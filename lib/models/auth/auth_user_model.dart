class AuthUserModel {
  String? id;
  String? userName;
  String? password;
  String? avatarUrl;
  String? email;

  AuthUserModel({
    this.id,
    this.userName,
    this.password,
    this.avatarUrl,
    this.email,
  });

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    password = json['password'];
    avatarUrl = json['avatar'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['password'] = password;
    data['avatar'] = avatarUrl;
    data['email'] = email;
    return data;
  }

  AuthUserModel copyWith(AuthUserModel newUser) {
    return AuthUserModel(
      id: newUser.id ?? id,
      userName: newUser.userName ?? userName,
      avatarUrl: newUser.avatarUrl ?? avatarUrl,
      password: newUser.password ?? password,
      email: newUser.email ?? email,
    );
  }
}
