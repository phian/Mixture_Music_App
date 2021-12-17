import 'package:flutter/material.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

import '../../../constants/app_constants.dart';
import '../../../widgets/marquee_text.dart';

class MiniMusicPlayer extends StatelessWidget {
  const MiniMusicPlayer({
    Key? key,
    required this.song,
    required this.onTap,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
  }) : super(key: key);

  final SongModel? song;
  final Function() onTap;
  final Function() onPlayPause;
  final Function() onNext;
  final Function() onPrevious;

  @override
  Widget build(BuildContext context) {
    if (song == null) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Material(
        child: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          height: AppConstants.playerMinHeight,
          child: Column(
            children: [
              LinearProgressIndicator(
                value: 0.3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.primaryColor,
                ),
                minHeight: 2.2,
                backgroundColor: theme.primaryColor.withOpacity(0.3),
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
                          song!.data.imgURL,
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
                              song!.data.title,
                              style: theme.textTheme.headline6!.copyWith(fontSize: 16),
                            ),
                            MarqueeText(
                              song!.data.artist,
                              //overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.caption!.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: onPrevious,
                        icon: Icon(
                          Icons.skip_previous,
                          color: theme.primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: onPlayPause,
                        icon: Icon(
                          Icons.pause,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: onNext,
                        icon: Icon(
                          Icons.skip_next,
                          color: theme.primaryColor,
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
