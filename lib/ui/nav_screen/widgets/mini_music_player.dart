import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:mixture_music_app/models/song_model.dart';

class MiniMusicPlayer extends StatelessWidget {
  const MiniMusicPlayer({
    Key? key,
    required this.playerMinHeight,
    required this.selectedSong,
  }) : super(key: key);

  final double playerMinHeight;
  final SongModel? selectedSong;

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      minHeight: playerMinHeight,
      maxHeight: MediaQuery.of(context).size.height,
      builder: (height, percentage) {
        if (selectedSong == null) {
          return SizedBox.shrink();
        }
        return Column(
          children: [
            LinearProgressIndicator(
              value: 0.6,
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
                    Image.network(
                      selectedSong!.coverImageUrl,
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedSong!.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
                          ),
                          Text(
                            selectedSong!.artist,
                            overflow: TextOverflow.ellipsis,
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
                    IconButton(
                      onPressed: () {
                        
                      },
                      icon: Icon(
                        Icons.clear,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
