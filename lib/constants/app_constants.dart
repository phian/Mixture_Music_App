import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/models/artist_model.dart';
import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

import 'app_colors.dart';

class AppConstants {
  static const double playerMinHeight = 60;
}

const defaultImgURL =
    'https://firebasestorage.googleapis.com/v0/b/mixturemusic-f0b97.appspot.com/o/coverImge%2Fdefault_img.jpeg?alt=media&token=f6eaa915-d6de-4e7f-a3f2-8d1ce8830d0b';

const libraryTitle = [
  'Favourites',
  'Playlists',
  'Artists',
  'Recent activity',
];

const onboardImg = [
  'https://firebasestorage.googleapis.com/v0/b/mixturemusic-f0b97.appspot.com/o/onboardImage%2Fab67616d0000b2731ae71e77aef7c34227027daa.jpg?alt=media&token=d6efa888-b8ac-4bc9-93d3-69dcfa6078b5',
  'https://firebasestorage.googleapis.com/v0/b/mixturemusic-f0b97.appspot.com/o/onboardImage%2FDark%20Paradise%20-%20Lana%20Del%20Rey.jpeg?alt=media&token=88a964b9-378f-4a49-810f-5ce6016f926a',
  'https://firebasestorage.googleapis.com/v0/b/mixturemusic-f0b97.appspot.com/o/onboardImage%2FDowntown%20-%20Allie%20X.jpeg?alt=media&token=349578a0-e0a6-44ce-a09e-ddf291d1054c',
  'https://firebasestorage.googleapis.com/v0/b/mixturemusic-f0b97.appspot.com/o/onboardImage%2FDean%20Lewis%20-%20Be%20Alright.jpeg?alt=media&token=d2ec7e56-58f2-47ca-a258-c113336f395d',
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

final artistModels = <ArtistModel>[
  ArtistModel(
    artistId: '0',
    artistName: 'Erik',
    imageUrl:
        'https://media-cdn.laodong.vn/Storage/NewsPortal/2021/8/3/937782/118654438_7452735827.jpg',
  ),
  ArtistModel(
    artistId: '1',
    artistName: 'Đức Phúc',
    imageUrl:
        'https://image.thanhnien.vn/768/uploaded/hienth/2020_01_23/53167553_2122687297838771_6964634450827149312_o_gnbk.jpg',
  ),
  ArtistModel(
    artistId: '2',
    artistName: 'Soobin Hoàng Sơn',
    imageUrl: 'https://vnn-imgs-f.vgcloud.vn/2019/02/22/09/img-3722.jpg',
  ),
  ArtistModel(
    artistId: '3',
    artistName: 'Đen Vâu',
    imageUrl:
        'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
  ),
  ArtistModel(
    artistId: '4',
    artistName: 'Trung Quân idol',
    imageUrl: 'https://znews-stc.zdn.vn/static/topic/person/trungquan.jpg',
  ),
];

final listSong = [
  SongModel(
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
  SongModel(
    id: 'id',
    data: SongData(
      title: 'Vết mưa',
      artist: 'Vũ Cát Tường',
      imgURL: 'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
      audioURL:
          'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    ),
  ),
  SongModel(
    id: 'id',
    data: SongData(
      title: 'Cơn mưa ngang qua',
      artist: 'Sơn Tùng MTP',
      imgURL: 'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
      audioURL: 'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    ),
  ),
  SongModel(
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
  SongModel(
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
  SongModel(
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
  SongModel(
    id: 'id',
    data: SongData(
      title: 'Cơn mưa ngang qua',
      artist: 'Sơn Tùng MTP',
      audioURL: 'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
      imgURL: 'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    ),
  ),
  SongModel(
    id: 'id',
    data: SongData(
      title: 'Vết mưa',
      artist: 'Vũ Cát Tường',
      imgURL: 'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
      audioURL:
          'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    ),
  ),
  SongModel(
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
  SongModel(
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
