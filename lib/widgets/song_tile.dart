import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/song_controller.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/ui/add_to_playlist/add_to_playlist_screen.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

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

  final _userData = Get.find<UserDataController>();
  final _songController = SongController();

  Future<void> onFavoriteTap() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    if (widget.isFavorite) {
      await _songController.removeSongFromFav(uid, widget.songModel);
    } else {
      await _songController.addSongToFav(uid, widget.songModel);
    }
    _userData.getAllUserFavSongs();
  }

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
                      Expanded(
                        child: Text(
                          widget.songModel.data.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: theme.textTheme.headline6?.copyWith(
                            fontSize: 16,
                            color: widget.isPlaying ? theme.primaryColor : theme.textTheme.headline6?.color,
                          ),
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
                  onPressed: onFavoriteTap,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            const SizedBox(width: 8),
            if (!widget.canMove)
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return _OptionSheet(
                        song: widget.songModel,
                        onFavoriteTap: onFavoriteTap,
                        onAddToPlaylist: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return AddToPlaylistSheet(song: widget.songModel);
                          },
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.more_horiz,
                  color: widget.isPlaying ? theme.primaryColor : theme.iconTheme.color,
                ),
              ),
            if (widget.canChoose) const Icon(Icons.drag_handle),
          ],
        ),
      ),
    );
  }
}

class _OptionSheet extends StatelessWidget {
  _OptionSheet({
    Key? key,
    required this.song,
    this.onFavoriteTap,
    this.onAddToPlaylist,
  }) : super(key: key);

  final SongModel song;
  final Future<void> Function()? onFavoriteTap;
  final Function()? onAddToPlaylist;

  final _userDataController = Get.put(UserDataController());

  bool isFavorite() {
    return _userDataController.favorites.contains(song);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Card(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Image.network(song.data.imgURL, height: 100),
              const SizedBox(height: 16),
              Text(
                song.data.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                song.data.artist,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: theme.textTheme.caption!.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: isFavorite()
                    ? Icon(
                        Icons.favorite_rounded,
                        color: theme.primaryColor,
                      )
                    : const Icon(Icons.favorite_border),
                title: isFavorite()
                    ? const Text('Remove from Favorites')
                    : const Text('Add to Favorites'),
                onTap: () {
                  onFavoriteTap?.call();
                  Get.back();
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.playlist_add),
                title: const Text('Add to Playlists'),
                onTap: onAddToPlaylist,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
