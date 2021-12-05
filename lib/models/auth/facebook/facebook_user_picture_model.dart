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
    height = json['height']?.toInt();
    isSilhouette = json['is_silhouette'];
    url = json['url']?.toString();
    width = json['width']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['is_silhouette'] = isSilhouette;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}
