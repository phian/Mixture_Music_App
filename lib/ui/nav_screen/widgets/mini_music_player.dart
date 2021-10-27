import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/models/song_model.dart';
import 'package:mixture_music_app/widgets/marquee_text.dart';

class MiniMusicPlayer extends StatelessWidget {
  const MiniMusicPlayer({
    Key? key,
    required this.song,
    required this.onTap,
  }) : super(key: key);

  final SongModel? song;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    if (song == null) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: onTap,
      child: Material(
        child: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          height: AppConstants.playerMinHeight,
          child: Column(
            children: [
              LinearProgressIndicator(
                value: 0.3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
                minHeight: 2.2,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'Artwork',
                        child: Image.network(
                          song!.coverImageUrl,
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MarqueeText(
                              song!.title,
                              //overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14),
                            ),
                            MarqueeText(
                              song!.artist,
                              //overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.pause,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
