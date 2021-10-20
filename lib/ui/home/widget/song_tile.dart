import 'package:flutter/material.dart';

import '../../../constants/theme.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    Key? key,
    required this.imageUrl,
    this.isPlaying = false,
  }) : super(key: key);

  final String imageUrl;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(imageUrl),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trời hôm nay nhiều mây cực',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppTheme.brightGrey,
                  ),
                ),
                Text(
                  'Đen Vâu',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontSize: 14,
                    color: AppTheme.subTextColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          if (isPlaying) Icon(Icons.play_arrow, color: AppTheme.primaryColor),
          Icon(Icons.more_horiz, color: AppTheme.subTextColor),
        ],
      ),
    );
  }
}
