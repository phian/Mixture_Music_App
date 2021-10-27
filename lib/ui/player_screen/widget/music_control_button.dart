import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicControlButton extends StatefulWidget {
  const MusicControlButton({
    Key? key,
    required this.onPlay,
    required this.onPause,
    required this.onNext,
    required this.onPrevious,
    required this.onShuffe,
    required this.onLoop,
  }) : super(key: key);

  final Function() onPlay;
  final Function() onPause;
  final Function() onNext;
  final Function() onPrevious;
  final Function(bool) onShuffe;
  final Function(bool) onLoop;

  @override
  State<MusicControlButton> createState() => _MusicControlButtonState();
}

class _MusicControlButtonState extends State<MusicControlButton> {
  bool isPlaying = false;
  bool isShuffe = false;
  bool isLoop = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        CupertinoButton(
          child: Icon(
            Icons.shuffle,
            color: isShuffe ? theme.colorScheme.onBackground : theme.disabledColor,
          ),
          onPressed: () {
            setState(() {
              isShuffe = !isShuffe;
            });
            widget.onShuffe(isShuffe);
          },
        ),
        Spacer(),
        CupertinoButton(
          child: Icon(
            Icons.skip_previous,
            size: 45,
            color: theme.primaryColor,
          ),
          onPressed: widget.onPrevious,
        ),
        CupertinoButton(
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 45,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(1000),
          color: theme.primaryColor,
          onPressed: () {
            setState(() {
              isPlaying = !isPlaying;
            });

            if (isPlaying) {
              widget.onPause();
            } else {
              widget.onPlay();
            }
          },
        ),
        CupertinoButton(
          child: Icon(
            Icons.skip_next,
            size: 45,
            color: theme.primaryColor,
          ),
          onPressed: widget.onNext,
        ),
        Spacer(),
        CupertinoButton(
          child: Icon(
            Icons.loop,
            color: isLoop ? theme.colorScheme.onBackground : theme.disabledColor,
          ),
          onPressed: () {
            setState(() {
              isLoop = !isLoop;
            });
            widget.onLoop(isLoop);
          },
        ),
      ],
    );
  }
}
