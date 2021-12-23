import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

class SongTile extends StatefulWidget {
  SongTile({
    Key? key,
    required this.songModel,
    required this.onTap,
    this.isPlaying = false,
    this.border,
    this.contentPadding,
    this.borderRadius,
    this.height,
    this.width,
    this.canChoose = false,
    this.canMove = false,
    this.initialCheck = false,
    this.onCheckChanged,
    this.isFavorite = false,
  }) : super(key: key);

  final bool isPlaying;
  final SongModel songModel;
  final Function() onTap;
  final BoxBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final bool canChoose;
  final bool canMove;
  final void Function(bool? value)? onCheckChanged;
  final bool initialCheck;
  final bool isFavorite;

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  late bool _isSelected = widget.initialCheck;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWellWrapper(
      onTap: widget.onTap,
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Container(
        padding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(border: widget.border),
        width: widget.width,
        height: widget.height,
        child: Row(
          children: [
            Visibility(
              visible: widget.canChoose,
              child: Checkbox(
                value: _isSelected,
                shape: const CircleBorder(),
                onChanged: widget.onCheckChanged != null
                    ? (value) {
                        if (value != null) {
                          setState(() {
                            _isSelected = value;
                            widget.onCheckChanged?.call(value);
                          });
                        }
                      }
                    : null,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  widget.songModel.data.imgURL,
                  loadingBuilder: (context, child, chunkEvent) {
                    if (chunkEvent == null) return child;
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final size = constraints.maxWidth;
                        return LoadingContainer(
                          height: size,
                          width: size,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: widget.isFavorite ? 9 : 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (widget.isPlaying)
                        Icon(
                          Icons.leaderboard_rounded,
                          color: theme.primaryColor,
                          size: 16,
                        ),
                      if (widget.isPlaying) const SizedBox(width: 4),
                      Text(
                        widget.songModel.data.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: theme.textTheme.headline6?.copyWith(
                          fontSize: 16,
                          color: widget.isPlaying
                              ? theme.primaryColor
                              : theme.textTheme.headline6?.color,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.songModel.data.artist,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: theme.textTheme.caption!.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            if (widget.isFavorite)
              Expanded(
                  flex: 1,
                  child: CupertinoButton(
                    child: Icon(
                      Icons.favorite_rounded,
                      color: theme.primaryColor,
                    ),
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  )),
            Visibility(
              visible: widget.canMove,
              child: const Icon(Icons.drag_handle),
            ),
          ],
        ),
      ),
    );
  }
}
