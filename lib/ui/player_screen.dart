import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    Key? key,
    required double playerMinHeight,
    required this.selectedSong,
  }) : _playerMinHeight = playerMinHeight, super(key: key);

  final double _playerMinHeight;
  final int? selectedSong;

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      minHeight: _playerMinHeight,
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
                      'https://i.scdn.co/image/ab6761610000e5ebc48716f91b7bf3016f5b6fbe',
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
                            'Trời hôm nay nhiều mây cực',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14),
                          ),
                          Text(
                            'Sơn Tùng MTP',
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
                      onPressed: () {},
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
