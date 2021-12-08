class FacebookUserPictureModel {
  int? height;
  bool? isSilhouette;
  String? url;
  int? width;

  FacebookUserPictureModel({
    this.height,
    this.isSilhouette,
    this.url,
    this.width,
  });

  FacebookUserPictureModel.fromJson(Map<String, dynamic> json) {
    height = json['data']['height'];
    isSilhouette = json['data']['is_silhouette'];
    url = json['data']['url'];
    width = json['data']['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data']['height'] = height;
    data['data']['is_silhouette'] = isSilhouette;
    data['data']['url'] = url;
    data['data']['width'] = width;
    return data;
  }

  FacebookUserPictureModel copyWith(FacebookUserPictureModel? pictureModel) {
    return FacebookUserPictureModel(
      width: pictureModel?.width ?? width,
      height: pictureModel?.height ?? height,
      url: pictureModel?.url ?? url,
      isSilhouette: pictureModel?.isSilhouette ?? isSilhouette,
    );
  }
}
