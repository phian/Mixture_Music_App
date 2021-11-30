import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/models/song_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';
import 'package:mixture_music_app/widgets/rounded_inkwell_wrapper.dart';

class AddSongCard extends StatefulWidget {
  const AddSongCard({
    Key? key,
    required this.song,
    required this.onAddButtonTap,
    required this.onPlayTap,
    this.imageHeight = 70.0,
    this.imageWidth = 70.0,
    this.imageRadius,
    this.isPlaying = false,
  }) : super(key: key);

  final SongModel song;
  final void Function(SongModel song) onAddButtonTap;
  final void Function(bool isPlaying) onPlayTap;
  final double imageWidth;
  final double imageHeight;
  final BorderRadius? imageRadius;
  final bool isPlaying;

  @override
  _AddSongCardState createState() => _AddSongCardState();
}

class _AddSongCardState extends State<AddSongCard> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  late bool _isPlaying = widget.isPlaying;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AddSongCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Here');
    setState(() {
      _isPlaying = widget.isPlaying;
      if (_isPlaying == false) {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWellWrapper(
          onTap: () {
            setState(() {
              _isPlaying = !_isPlaying;
            });

            if (_isPlaying) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }

            widget.onPlayTap.call(_isPlaying);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: widget.imageRadius ?? BorderRadius.zero,
                child: Image.network(
                  widget.song.coverImageUrl ?? '',
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  loadingBuilder: (_, child, chunkEvent) {
                    if (chunkEvent == null) return child;

                    return LoadingContainer(width: 30.0, height: 30.0, borderRadius: BorderRadius.circular(4.0));
                  },
                ),
              ),
              AnimatedIcon(icon: AnimatedIcons.play_pause, progress: _animationController, size: 40.0, color: AppColors.white),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.song.title ?? 'Song Name', style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 20.0)),
              const SizedBox(height: 4.0),
              Text(widget.song.artist ?? 'Artist Name', style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14.0)),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        RoundedInkWellWrapper(
          onTap: () {
            widget.onAddButtonTap.call(widget.song);
          },
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.add, color: Theme.of(context).primaryColor),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Theme.of(context).primaryColor),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
