import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/models/playlist_model.dart';
import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

import 'app_colors.dart';

class AppConstants {
  static const double playerMinHeight = 60;
}

const defaultImg =
    'https://firebasestorage.googleapis.com/v0/b/mixturemusic-f0b97.appspot.com/o/coverImge%2Fdefault_img.jpg?alt=media&token=8bf1736d-96c1-4d7c-984a-ab4836753859';

const libraryTitle = [
  'Favourites',
  'Playlists',
  'Artists',
  'Recent activity',
];

const accountScreenGridData = [
  'Songs',
  'Upload',
  'MV',
  'On Device',
  'Album',
  'Artists',
];

const accountScreenGridIcon = [
  Icons.library_music,
  Icons.upload,
  Icons.music_video,
  Icons.download,
  Icons.album,
  Icons.account_circle,
];

const accountScreenIconColors = [
  AppColors.cA808F8,
  AppColors.c417DFF,
  AppColors.cFE8238,
  AppColors.c434CE5,
  AppColors.cFF4C4E,
  AppColors.c0791FD,
];

const personalTitle = [
  'Playlist',
  'Mixed songs',
  'Recent activity',
];

final mixedSongUrls = [
  'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
  'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
  'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
  'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
];

final personalSuggestPlaylists = [
  PlaylistModel(
    imageUrl:
        'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    playlistName: 'Đen Vâu',
    owner: 'Nguyễn Phi Ân',
  ),
  PlaylistModel(
    imageUrl:
        'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
    playlistName: 'Trung Quân idol',
    owner: 'Nguyễn Phi Ân',
  ),
  PlaylistModel(
    imageUrl:
        'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    playlistName: 'Vũ Cát Tường',
    owner: 'Nguyễn Phi Ân',
  ),
  PlaylistModel(
    imageUrl:
        'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    playlistName: 'Sơn Tùng MTP',
    owner: 'Nguyễn Phi Ân',
  ),
];

final libraryExampleModels = [
  LibraryModel(
    imageUrl:
        'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    libraryTitle: 'Trời hôm nay nhiều mây cực',
    librarySubTitle: 'Đen vâu',
    isFavourite: true,
  ),
  LibraryModel(
    libraryTitle: 'Gọi mưa',
    librarySubTitle: 'Trung Quân Idol',
    imageUrl:
        'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
    isFavourite: true,
  ),
  LibraryModel(
    libraryTitle: 'Vết mưa',
    librarySubTitle: 'Vũ Cát Tường',
    imageUrl:
        'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    isFavourite: true,
  ),
  LibraryModel(
    librarySubTitle: 'Cơn mưa ngang qua',
    libraryTitle: 'Sơn Tùng MTP',
    imageUrl:
        'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    isFavourite: true,
  ),
  LibraryModel(
    librarySubTitle: 'Dấu mưa',
    libraryTitle: 'Trung Quân Idol',
    imageUrl:
        'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
    isFavourite: true,
  ),
];

final listSong = [
  Song(
    id: 'id',
    data: SongData(
      title: 'Trời hôm nay nhiều mây cực cực cực cực cực cực',
      artist: 'Đen Vâu',
      imgURL:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
      audioURL:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Vết mưa',
      artist: 'Vũ Cát Tường',
      imgURL:
          'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
      audioURL:
          'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Cơn mưa ngang qua',
      artist: 'Sơn Tùng MTP',
      imgURL:
          'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
      audioURL:
          'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Gọi mưa',
      artist: 'Trung Quân Idol',
      imgURL:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
      audioURL:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Trời hôm nay nhiều mây cực',
      artist: 'Đen Vâu',
      imgURL:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
      audioURL:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Dấu mưa',
      artist: 'Trung Quân Idol',
      imgURL:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
      audioURL:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Cơn mưa ngang qua',
      artist: 'Sơn Tùng MTP',
      audioURL:
          'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
      imgURL:
          'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Vết mưa',
      artist: 'Vũ Cát Tường',
      imgURL:
          'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
      audioURL:
          'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Gọi mưa',
      artist: 'Trung Quân Idol',
      imgURL:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
      audioURL:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
    ),
  ),
  Song(
    id: 'id',
    data: SongData(
      title: 'Dấu mưa',
      artist: 'Trung Quân Idol',
      imgURL:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
      audioURL:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
    ),
  ),
];
