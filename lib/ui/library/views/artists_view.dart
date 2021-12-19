import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/models/artist_model.dart';
import 'package:mixture_music_app/ui/library/widgets/artist_card.dart';
import 'package:mixture_music_app/ui/library/widgets/shuffle_and_swap_view.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({
    Key? key,
    required this.onArtistTap,
    required this.artists,
  }) : super(key: key);

  final void Function(ArtistModel artist) onArtistTap;
  final List<ArtistModel> artists;

  @override
  _ArtistsViewState createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  ViewType _viewType = ViewType.list;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          firstChild: _ArtistsListView(
            onArtistTap: widget.onArtistTap,
            artists: widget.artists,
          ),
          secondChild: _ArtistGridView(
            onArtistTap: widget.onArtistTap,
            artists: widget.artists,
          ),
          crossFadeState: _viewType == ViewType.list ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

class _ArtistsListView extends StatelessWidget {
  const _ArtistsListView({Key? key, required this.onArtistTap, required this.artists}) : super(key: key);
  final void Function(ArtistModel artist) onArtistTap;
  final List<ArtistModel> artists;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          ...List.generate(
            artists.length,
            (index) => ArtistCard(
              artist: artists[index],
              onTap: () {
                onArtistTap.call(artists[index]);
              },
              viewType: ViewType.list,
            ),
          ),
          const SizedBox(height: kBottomNavigationBarHeight + 32.0),
        ],
      ),
    );
  }
}

class _ArtistGridView extends StatelessWidget {
  const _ArtistGridView({Key? key, required this.onArtistTap, required this.artists}) : super(key: key);
  final void Function(ArtistModel artist) onArtistTap;
  final List<ArtistModel> artists;

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
                artists.length,
                (index) => Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: ArtistCard(
                    artist: artists[index],
                    onTap: () {
                      onArtistTap.call(artists[index]);
                    },
                    viewType: ViewType.grid,
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
