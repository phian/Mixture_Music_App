class AuthUserModel {
  String? userName;
  String? password;

  AuthUserModel({
    this.userName,
    this.password,
  });

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name']?.toString();
    password = json['password']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_name'] = userName;
    data['password'] = password;
    return data;
  }
}
