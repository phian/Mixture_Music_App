import 'package:flutter/material.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

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

class _LibraryGridViewCardState extends State<LibraryGridViewCard> {
  late bool _isPlaying = widget.isPlaying;

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
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                      child: Icon(
                        _isPlaying ? Icons.pause_sharp : Icons.play_arrow,
                        color: Theme.of(context).primaryColor,
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
