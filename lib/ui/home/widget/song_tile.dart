import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';


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
                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
                ),
                Text(
                  'Đen Vâu',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          if (isPlaying)
            Icon(
              Icons.play_arrow,
              color: Theme.of(context).primaryColor,
            ),
          Icon(
            Icons.more_horiz,
            //TODO: sửa theo theme
            color: AppColors.subTextColor,
          ),
        ],
      ),
    );
  }
}
