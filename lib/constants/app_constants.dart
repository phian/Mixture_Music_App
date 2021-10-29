import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/models/playlist_model.dart';
import 'package:mixture_music_app/models/song_model.dart';
import 'app_colors.dart';

class AppConstants {
  static const double playerMinHeight = 60;
}

const libraryTitle = [
  'All',
  'Favourites',
  'Playlists',
  'Albums',
  'Artists',
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

final personalPlaylists = [
  PlaylistModel(
    imageUrl: 'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    playlistName: 'Đen Vâu',
    owner: 'Nguyễn Phi Ân',
  ),
  PlaylistModel(
    imageUrl: 'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
    playlistName: 'Trung Quân idol',
    owner: 'Nguyễn Phi Ân',
  ),
];

final personalSuggestPlaylists = [
  PlaylistModel(
    imageUrl: 'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    playlistName: 'Vũ Cát Tường',
    owner: 'Nguyễn Phi Ân',
  ),
  PlaylistModel(
    imageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    playlistName: 'Sơn Tùng MTP',
    owner: 'Nguyễn Phi Ân',
  ),
];

final libraryExampleModels = [
  LibraryModel(
    imageUrl: 'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    libraryTitle: 'Trời hôm nay nhiều mây cực',
    librarySubTitle: 'Đen vâu',
    isFavourite: true,
  ),
  LibraryModel(
    libraryTitle: 'Gọi mưa',
    librarySubTitle: 'Trung Quân Idol',
    imageUrl: 'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
    isFavourite: true,
  ),
  LibraryModel(
    libraryTitle: 'Vết mưa',
    librarySubTitle: 'Vũ Cát Tường',
    imageUrl: 'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    isFavourite: true,
  ),
  LibraryModel(
    librarySubTitle: 'Cơn mưa ngang qua',
    libraryTitle: 'Sơn Tùng MTP',
    imageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    isFavourite: true,
  ),
  LibraryModel(
    librarySubTitle: 'Dấu mưa',
    libraryTitle: 'Trung Quân Idol',
    imageUrl: 'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
    isFavourite: true,
  ),
];

const listSong = [
  SongModel(
    id: 01,
    title: 'Trời hôm nay nhiều mây cực cực cực cực cực cực',
    artist: 'Đen Vâu',
    coverImageUrl: 'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Gọi mưa',
    artist: 'Trung Quân Idol',
    coverImageUrl: 'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Vết mưa',
    artist: 'Vũ Cát Tường',
    coverImageUrl: 'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Cơn mưa ngang qua',
    artist: 'Sơn Tùng MTP',
    coverImageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Dấu mưa',
    artist: 'Trung Quân Idol',
    coverImageUrl: 'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Trời hôm nay nhiều mây cực',
    artist: 'Đen Vâu',
    coverImageUrl: 'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Gọi mưa',
    artist: 'Trung Quân Idol',
    coverImageUrl: 'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Vết mưa',
    artist: 'Vũ Cát Tường',
    coverImageUrl: 'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Cơn mưa ngang qua',
    artist: 'Sơn Tùng MTP',
    coverImageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
  ),
  SongModel(
    id: 01,
    title: 'Dấu mưa',
    artist: 'Trung Quân Idol',
    coverImageUrl: 'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
  ),
];
