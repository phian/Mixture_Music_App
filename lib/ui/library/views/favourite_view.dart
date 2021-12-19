import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/ui/library/widgets/library_grid_view_card.dart';
import 'package:mixture_music_app/ui/library/widgets/library_list_view_card.dart';
import 'package:mixture_music_app/ui/library/widgets/shuffle_and_swap_view.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key, required this.libraries}) : super(key: key);

  final List<LibraryModel> libraries;

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  ViewType _viewType = ViewType.list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ShuffleAndSwapView(
            onShuffleTap: () {},
            onSwapViewTap: (viewType) {
              setState(() {
                _viewType = viewType;
              });
            },
            visibleSwapViewIcon: true,
          ),
        ),
        AnimatedCrossFade(
          firstChild: _LibraryListView(libraries: widget.libraries),
          secondChild: _LibraryGridView(libraries: widget.libraries),
          crossFadeState: _viewType == ViewType.list ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

class _LibraryListView extends StatefulWidget {
  const _LibraryListView({required this.libraries});

  final List<LibraryModel> libraries;

  @override
  State<_LibraryListView> createState() => _LibraryListViewState();
}

class _LibraryListViewState extends State<_LibraryListView> {
  int _playingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            widget.libraries.length,
            (index) => LibraryListViewCard(
              libraryModel: widget.libraries[index],
              onTap: (isPlaying) {
                if (isPlaying) {
                  setState(() {
                    _playingIndex = index;
                  });
                } else {
                  _playingIndex = -1;
                }
              },
              isPlaying: _playingIndex == index,
              borderRadius: BorderRadius.zero,
              cardColor: Colors.transparent,
              cardBorder: index == 0
                  ? const Border.symmetric(horizontal: BorderSide(width: 1.0, color: Colors.grey))
                  : const Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
            ),
          ),
          const SizedBox(height: kBottomNavigationBarHeight + 32.0),
        ],
      ),
    );
  }
}

class _LibraryGridView extends StatefulWidget {
  const _LibraryGridView({required this.libraries});

  final List<LibraryModel> libraries;

  @override
  State<_LibraryGridView> createState() => _LibraryGridViewState();
}

class _LibraryGridViewState extends State<_LibraryGridView> {
  int _playingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 24.0,
            runSpacing: 8.0,
            children: [
              ...List.generate(
                widget.libraries.length,
                (index) => Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: LibraryGridViewCard(
                    libraryModel: widget.libraries[index],
                    onTap: (isPlaying) {
                      if (isPlaying) {
                        setState(() {
                          _playingIndex = index;
                        });
                      } else {
                        _playingIndex = -1;
                      }
                    },
                    imageRadius: BorderRadius.circular(16.0),
                    isPlaying: _playingIndex == index,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kBottomNavigationBarHeight + 32.0),
        ],
      ),
    );
  }
}
