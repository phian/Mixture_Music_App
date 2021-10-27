class SongModel {
  final int id;
  final String tilte;
  final String artist;
  final String coverImageUrl;
  final bool isFavorite;

  SongModel({
    required this.id,
    required this.tilte,
    required this.artist,
    required this.coverImageUrl,
    this.isFavorite = false,
  });
}
