import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import '../../widgets/marquee_text.dart';

import 'widget/music_control_button.dart';

class MusicPlayerScreen extends StatelessWidget {
  MusicPlayerScreen({Key? key}) : super(key: key);

  final controller = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Now playing",
          style: theme.textTheme.caption!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
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
            onPressed: () {},
            child: Icon(
              Icons.favorite_border,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Hero(
                  tag: "Artwork",
                  child: Image.network(
                    controller.selectedSong.value!.coverImageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              MarqueeText(
                controller.selectedSong.value!.title,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 26,
                    ),
                horizontalPadding: 10,
              ),
              SizedBox(height: 4),
              MarqueeText(
                controller.selectedSong.value!.artist,
                style: theme.textTheme.caption!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
                horizontalPadding: 10,
              ),
              SizedBox(height: 16),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  activeTrackColor: theme.primaryColor.withOpacity(0.8),
                  inactiveTrackColor: theme.primaryColor.withOpacity(0.2),
                  thumbColor: theme.primaryColor.withOpacity(0.8),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                  overlayShape: RoundSliderThumbShape(enabledThumbRadius: 10),
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
                  children: [
                    Text('00:31'),
                    Spacer(),
                    Text('03:45'),
                  ],
                ),
              ),
              Spacer(),
              MusicControlButton(
                onPlay: () {},
                onPause: () {},
                onNext: () {},
                onPrevious: () {},
                onLoop: (value) {},
                onShuffe: (value) {},
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
