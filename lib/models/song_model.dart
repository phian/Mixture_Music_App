class SongModel {
  final int id;
  final String title;
  final String artist;
  final String coverImageUrl;
  final bool isFavorite;

  const SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverImageUrl,
    this.isFavorite = false,
  });
}
