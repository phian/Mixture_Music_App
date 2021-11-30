class PlaylistModel {
  int? playListId;
  String? imageUrl;
  String? playlistName;
  String? owner;
  bool? isFavourite;
  int? createDate;
  int? totalTrack;

  PlaylistModel({this.playListId, this.imageUrl, this.playlistName, this.owner, this.isFavourite, this.createDate, this.totalTrack});

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    playListId = json['id'];
    imageUrl = json['image_url']?.toString();
    playlistName = json['playlist_name']?.toString();
    owner = json['owner']?.toString();
    isFavourite = json['is_favourite'];
    createDate = json['create_date'];
    totalTrack = json['total_track'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = playListId;
    data['image_url'] = imageUrl;
    data['playlist_name'] = playlistName;
    data['owner'] = owner;
    data['is_favourite'] = isFavourite;
    data['create_date'] = createDate;
    data['total_track'] = totalTrack;
    return data;
  }
}
