import 'package:flutter/material.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/rounded_inkwell_wrapper.dart';

class LibraryGridViewCard extends StatefulWidget {
  const LibraryGridViewCard({
    Key? key,
    required this.songModel,
    this.titleStyle,
    required this.onTap,
    this.imageRadius,
    this.isPlaying = false,
  }) : super(key: key);

  final SongModel songModel;
  final TextStyle? titleStyle;
  final void Function() onTap;
  final BorderRadius? imageRadius;
  final bool isPlaying;

  @override
  State<LibraryGridViewCard> createState() => _LibraryGridViewCardState();
}

class _LibraryGridViewCardState extends State<LibraryGridViewCard>
    with SingleTickerProviderStateMixin {
  late bool _isPlaying = widget.isPlaying;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LibraryGridViewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _isPlaying = widget.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              InkWellWrapper(
                color: Colors.transparent,
                borderRadius: widget.imageRadius,
                onTap: widget.onTap,
                child: ClipRRect(
                  borderRadius: widget.imageRadius,
                  child: Ink.image(
                    image: NetworkImage(widget.songModel.data.imgURL),
                    height: MediaQuery.of(context).size.width * 0.27,
                    width: MediaQuery.of(context).size.width * 0.27,
                  ),
                ),
              ),
              if (_isPlaying)
                RoundedInkWellWrapper(
                  onTap: widget.onTap,
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.leaderboard,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.25),
          child: Text(
            widget.songModel.data.title,
            style: widget.titleStyle ??
                Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
          ),
        )
      ],
    );
  }
}
