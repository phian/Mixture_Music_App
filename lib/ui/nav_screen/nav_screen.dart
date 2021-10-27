import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/models/facebook/facebook_user_model.dart';
import 'package:mixture_music_app/models/facebook/facebook_user_picture_model.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/library/library_screen.dart';
import 'package:mixture_music_app/ui/personal_screen/personal_screen.dart';

import '../home/home.dart';
import '../player_screen/controller/music_player_controller.dart';
import '../search_screen.dart';
import 'widgets/mini_music_player.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int selectedScreenIndex = 0;

  final _screen = [
    Home(),
    const SearchScreen(),
    const LibraryScreen(),
    PersonalScreen(
      userModel: FacebookUserModel(
        id: 1,
        name: 'Đen Vâu',
        email: 'denvau@gmail.com',
        picture: FacebookUserPictureModel(
          url: 'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/'
              'avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
        ),
      ),
    ),
  ];

  final musicController = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: _screen
              .asMap()
              .map((i, screen) => MapEntry(
                    i,
                    Offstage(
                      offstage: selectedScreenIndex != i,
                      child: screen,
                    ),
                  ))
              .values
              .toList()
            ..add(
              Offstage(
                offstage: musicController.selectedSong.value == null,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MiniMusicPlayer(
                    song: musicController.selectedSong.value,
                    onTap: () {
                      Get.toNamed(AppRoutes.musicPlayerScreen);
                    },
                  ),
                ),
              ),
            ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedScreenIndex,
        onTap: (index) {
          setState(() {
            selectedScreenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_outlined),
            activeIcon: Icon(Icons.library_music),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Personal',
          ),
        ],
      ),
    );
  }
}
