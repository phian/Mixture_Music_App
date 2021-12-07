import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/auth_controller.dart';
import 'package:mixture_music_app/ui/search_screen/search_screen.dart';

import '../../routing/routes.dart';
import '../home/home.dart';
import '../library/library_screen.dart';
import '../player_screen/controller/music_player_controller.dart';
import '../settings_screen/settings_screen.dart';
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
    SearchScreen(),
    const LibraryScreen(),
    const SettingsScreen(),
  ];

  final musicController = Get.put(MusicPlayerController());
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    print(_authController.googleUser);
    _getFbUserData();
  }

  void _getFbUserData() async {
    var res = await _authController.getFacebookUserData();
    print(res.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Stack(
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
                    .toList(),
              ),
            ),
            MiniMusicPlayer(
              song: musicController.selectedSong.value,
              onTap: () {
                Get.toNamed(AppRoutes.musicPlayerScreen);
              },
              onNext: () {},
              onPlayPause: () {},
              onPrevious: () {},
            ),
          ],
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
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings_sharp),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
