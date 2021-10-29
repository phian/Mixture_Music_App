import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../models/song_model.dart';
import '../../../widgets/marquee_text.dart';

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
                              style: theme.textTheme.headline6!.copyWith(fontSize: 16),
                            ),
                            MarqueeText(
                              song!.artist,
                              //overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.caption!.copyWith(
                                fontSize: 14,
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
