import 'facebook_user_picture_model.dart';

class FacebookUserModel {
  int? id;
  String? name;
  String? email;
  FacebookUserPictureModel? picture;

  FacebookUserModel({
    this.id,
    this.name,
    this.email,
    this.picture,
  });

  FacebookUserModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    email = json['email'];
    picture = (json['picture'] != null)
        ? FacebookUserPictureModel.fromJson(json['picture'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    if (picture != null) {
      data['picture'] = picture?.toJson();
    }
    return data;
  }
}
