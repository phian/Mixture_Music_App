import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/ui/player_screen/widget/list_playlist.dart';

import '../../widgets/marquee_text.dart';
import 'controller/music_player_controller.dart';
import 'widget/music_control_button.dart';

class MusicPlayerScreen extends StatelessWidget {
  MusicPlayerScreen({Key? key}) : super(key: key);

  final controller = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                'Now playing',
                style: theme.textTheme.headline6,
              ),
              centerTitle: true,
              leading: CupertinoButton(
                onPressed: Get.back,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              actions: [
                CupertinoButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return ListPlayList();
                      },
                    );
                  },
                  child: Icon(
                    Icons.playlist_add_rounded,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Hero(
                        tag: 'Artwork',
                        child: Image.network(
                          controller.selectedSong.value!.imgURL,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: MarqueeText(
                            controller.selectedSong.value!.title,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 26,
                                    ),
                            horizontalPadding: 10,
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            // controller.selectedSong.update((song) {
                            //   song!.isFavorite = !song.isFavorite;
                            // });
                          },
                          child: Icon(
                            Icons.favorite_border,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    MarqueeText(
                      controller.selectedSong.value!.artist,
                      style: theme.textTheme.caption!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      horizontalPadding: 10,
                    ),
                    const SizedBox(height: 16),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        activeTrackColor: theme.primaryColor.withOpacity(0.8),
                        inactiveTrackColor: theme.primaryColor.withOpacity(0.2),
                        thumbColor: theme.primaryColor.withOpacity(0.8),
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 5),
                        overlayShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayColor: theme.primaryColor.withOpacity(0.1),
                      ),
                      child: Slider(
                        value: 0.3,
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: const [
                          Text(
                            '00:31',
                            //style: theme.textTheme.caption,
                          ),
                          Spacer(),
                          Text(
                            '03:45',
                            //style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    MusicControlButton(
                      onPlay: () {},
                      onPause: () {},
                      onNext: () {},
                      onPrevious: () {},
                      onLoop: (value) {},
                      onShuffe: (value) {},
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
