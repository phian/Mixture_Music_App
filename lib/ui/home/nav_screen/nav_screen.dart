import 'package:flutter/material.dart';
import 'package:mixture_music_app/models/song_model.dart';

import '../home.dart';
import '../../library_screen.dart';
import 'widget/mini_music_player.dart';
import '../../search_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  static const double _playerMinHeight = 60;
  int _selectedIndex = 0;
  SongModel? selectedSong;

  final _screen = [
    Home(),
    SearchScreen(),
    LibraryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _screen
            .asMap()
            .map((i, screen) => MapEntry(
                  i,
                  Offstage(
                    offstage: _selectedIndex != i,
                    child: screen,
                  ),
                ))
            .values
            .toList()
          ..add(
            Offstage(
              offstage: selectedSong == null,
              child: MiniMusicPlayer(playerMinHeight: _playerMinHeight, selectedSong: selectedSong),
            ),
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() {
          _selectedIndex = i;
        }),
        items: [
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
        ],
      ),
    );
  }
}
