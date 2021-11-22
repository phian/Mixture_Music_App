import 'package:flutter/material.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

import '../models/song_model.dart';

class SongTile extends StatefulWidget {
  const SongTile({
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
    this.onCheckChanged,
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

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  bool _isSelected = false;

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
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  widget.songModel.coverImageUrl ?? '',
                  loadingBuilder: (context, child, chunkEvent) {
                    if (chunkEvent == null) return child;

                    return const LoadingContainer(width: 30.0, height: 30.0);
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.songModel.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: theme.textTheme.headline6?.copyWith(
                      fontSize: 16,
                      color: widget.isPlaying ? theme.primaryColor : theme.textTheme.headline6?.color,
                    ),
                  ),
                  Text(
                    '${widget.songModel.artist}',
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
            if (widget.isPlaying)
              Icon(
                Icons.play_arrow,
                color: theme.primaryColor,
              ),
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
