import 'package:flutter/material.dart';

import '../../../models/song_model.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    Key? key,
    required this.songModel,
    required this.onTap,
    this.isPlaying = false,
  }) : super(key: key);

  final bool isPlaying;
  final SongModel songModel;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(songModel.coverImageUrl),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songModel.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 16),
                  ),
                  Text(
                    songModel.artist,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            if (isPlaying)
              Icon(
                Icons.play_arrow,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
