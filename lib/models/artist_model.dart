class ArtistModel {
  ArtistModel({
    String? artistId,
    String? imageUrl,
    String? artistName,
  }) {
    _artistId = artistId;
    _imageUrl = imageUrl;
    _artistName = artistName;
  }

  ArtistModel.fromJson(dynamic json) {
    _artistId = json['artist_id'];
    _imageUrl = json['image_url'];
    _artistName = json['artist_name'];
  }

  String? _artistId;
  String? _imageUrl;
  String? _artistName;

  String? get artistId => _artistId;

  String? get imageUrl => _imageUrl;

  String? get artistName => _artistName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['artist_id'] = _artistId;
    map['image_url'] = _imageUrl;
    map['artist_name'] = _artistName;
    return map;
  }
}
