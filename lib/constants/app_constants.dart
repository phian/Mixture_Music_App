import 'package:mixture_music_app/models/artist_model.dart';


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

