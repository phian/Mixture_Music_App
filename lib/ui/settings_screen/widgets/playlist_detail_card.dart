import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.playListName,
    required this.songs,
    required this.totalTracks,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final String playListName;
  final int totalTracks;
  final List<SongModel> songs;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: songs.length < 4
                  ? Image.network(
                      defaultImgURL,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, chunkEvent) {
                        if (chunkEvent == null) return child;

                        return const LoadingContainer(width: 80.0, height: 80.0);
                      },
                    )
                  : ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 80.0),
                      child: Wrap(
                        children: [
                          ...List.generate(
                            4,
                            (index) => Image.network(
                              songs[index].data.imgURL,
                              width: 40.0,
                              height: 40.0,
                              fit: BoxFit.cover,
                              loadingBuilder: (_, child, chunkEvent) {
                                if (chunkEvent == null) return child;

                                return const LoadingContainer(width: 40.0, height: 40.0);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playListName,
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '$totalTracks track(s)',
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
