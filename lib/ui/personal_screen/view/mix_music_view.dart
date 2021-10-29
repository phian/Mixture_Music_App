import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/ui/personal_screen/widgets/mix_song_card.dart';

class MixMusicView extends StatefulWidget {
  const MixMusicView({Key? key}) : super(key: key);

  @override
  _MixMusicViewState createState() => _MixMusicViewState();
}

class _MixMusicViewState extends State<MixMusicView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.all(16.0),
            child: MixSongCard(
              titleImageUrl: 'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
              songImages: mixedSongUrls,
              cardTitle: 'Song you will like',
              songAmount: 50,
              onShuffleTap: () {},
            ),
          ),
        )
      ],
    );
  }
}
