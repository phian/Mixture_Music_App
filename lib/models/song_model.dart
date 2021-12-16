import 'dart:convert';

class SongModel {
  String id;
  String title;
  String artist;
  String audioURL;
  String imgURL;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.audioURL,
    required this.imgURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'audio_url': audioURL,
      'img_url': imgURL,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map, String id) {
    return SongModel(
      id: map['id'] ?? id,
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      audioURL: map['audio_url'] ?? '',
      imgURL: map['img_url'] ?? '',
    );
  }
}
