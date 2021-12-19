import 'package:mixture_music_app/constants/app_constants.dart';

class SongData {
  String title;
  String artist;
  String audioURL;
  String imgURL;

  SongData({
    required this.title,
    required this.artist,
    required this.audioURL,
    required this.imgURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
      'audio_url': audioURL,
      'img_url': imgURL,
    };
  }

  factory SongData.fromMap(Map<String, dynamic> map) {
    return SongData(
      title: map['title'] ?? 'Unknow',
      artist: map['artist'] ?? 'Unknow',
      audioURL: map['audio_url'] ?? '',
      imgURL: map['img_url'] ?? defaultImgURL,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SongData &&
      other.title == title &&
      other.artist == artist &&
      other.audioURL == audioURL &&
      other.imgURL == imgURL;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      artist.hashCode ^
      audioURL.hashCode ^
      imgURL.hashCode;
  }
}
