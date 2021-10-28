class PlaylistModel {
  String? imageUrl;
  String? playlistName;
  String? owner;
  bool? isFavourite;

  PlaylistModel({
    this.imageUrl,
    this.playlistName,
    this.owner,
    this.isFavourite,
  });

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url']?.toString();
    playlistName = json['playlist_name']?.toString();
    owner = json['owner']?.toString();
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['playlist_name'] = playlistName;
    data['owner'] = owner;
    data['is_favourite'] = isFavourite;
    return data;
  }
}
