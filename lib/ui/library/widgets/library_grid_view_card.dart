import 'package:flutter/material.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';
import 'package:mixture_music_app/widgets/rounded_inkwell_wrapper.dart';

class LibraryGridViewCard extends StatefulWidget {
  const LibraryGridViewCard({
    Key? key,
    required this.libraryModel,
    this.titleStyle,
    this.onTap,
    this.imageRadius,
    this.isPlaying = false,
  }) : super(key: key);

  final LibraryModel libraryModel;
  final TextStyle? titleStyle;
  final void Function(bool isPlaying)? onTap;
  final BorderRadius? imageRadius;
  final bool isPlaying;

  @override
  State<LibraryGridViewCard> createState() => _LibraryGridViewCardState();
}

class _LibraryGridViewCardState extends State<LibraryGridViewCard> with SingleTickerProviderStateMixin {
  late bool _isPlaying = widget.isPlaying;
  late final AnimationController _aniController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

  @override
  void dispose() {
    _aniController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LibraryGridViewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _isPlaying = widget.isPlaying;
    });

    if (_isPlaying == false) {
      _aniController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          child: widget.libraryModel.imageUrl != null
              ? Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    InkWellWrapper(
                      color: Colors.transparent,
                      borderRadius: widget.imageRadius,
                      onTap: widget.onTap != null
                          ? () {
                              setState(() {
                                if (_isPlaying) {
                                  _aniController.reverse();
                                } else {
                                  _aniController.forward();
                                }

                                _isPlaying = !_isPlaying;
                                widget.onTap?.call(_isPlaying);
                              });
                            }
                          : null,
                      child: ClipRRect(
                        borderRadius: widget.imageRadius,
                        child: Ink.image(
                          image: NetworkImage(widget.libraryModel.imageUrl!),
                          height: MediaQuery.of(context).size.width * 0.27,
                          width: MediaQuery.of(context).size.width * 0.27,
                        ),
                      ),
                    ),
                    RoundedInkWellWrapper(
                      onTap: () {
                        setState(() {
                          if (_isPlaying) {
                            _aniController.reverse();
                          } else {
                            _aniController.forward();
                          }

                          _isPlaying = !_isPlaying;
                          widget.onTap?.call(_isPlaying);
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4.0),
                        child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: _aniController, color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                )
              : LoadingContainer(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  borderRadius: BorderRadius.circular(30.0),
                ),
        ),
        const SizedBox(height: 16.0),
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.25),
          child: Text(
            widget.libraryModel.libraryTitle ?? "Library's title",
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
