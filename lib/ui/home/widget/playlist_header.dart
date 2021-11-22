import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

class PlaylistHeader extends StatelessWidget {
  const PlaylistHeader({
    Key? key,
    required this.coverImageUrl,
  }) : super(key: key);

  final List<String> coverImageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Card(
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) => Image.network(
                        coverImageUrl[index],
                        loadingBuilder: (context, child, chunkEvent) {
                          if (chunkEvent == null) return child;

                          return const LoadingContainer(width: 30.0, height: 30.0);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: theme.primaryColorLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.leaderboard,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Playlist",
                  style: theme.textTheme.headline5!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Created based on weather',
                  style: theme.textTheme.caption!.copyWith(
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 30),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
