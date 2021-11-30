class SongModel {
  int? id;
  int? playlistId;
  String? title;
  String? artist;
  String? coverImageUrl;
  bool isFavorite;

  SongModel({
    this.id,
    this.playlistId,
    this.title,
    this.artist,
    this.coverImageUrl,
    this.isFavorite = false,
  });
}
