import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/models/facebook/facebook_user_model.dart';
import 'package:mixture_music_app/ui/personal_screen/widgets/create_playlist_button.dart';
import 'package:mixture_music_app/ui/personal_screen/widgets/grid_card.dart';
import 'package:mixture_music_app/ui/personal_screen/widgets/playlist_card.dart';
import 'package:mixture_music_app/widgets/fade_indexed_stack.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key, required this.userModel}) : super(key: key);
  final FacebookUserModel userModel;

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16.0,
                left: 16.0,
              ),
              child: Text(
                'Personal Info',
                style: AppTextStyles.lightTextTheme.headline4?.copyWith(
                  fontSize: 30.0,
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      widget.userModel.picture!.url!,
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.userModel.name!,
                        style: AppTextStyles.lightTextTheme.headline5?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.userModel.email!,
                        style: AppTextStyles.lightTextTheme.caption?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Library',
                style: AppTextStyles.lightTextTheme.headline5?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          2,
                          (i) => Expanded(
                            child: Row(
                              children: [
                                ...List.generate(
                                  3,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: GridCard(
                                      cardIcon: accountScreenGridIcon[i == 0 ? index : index + 3],
                                      cardTitle: accountScreenGridData[i == 0 ? index : index + 3],
                                      iconColor: accountScreenIconColors[i == 0 ? index : index + 3],
                                      width: MediaQuery.of(context).size.width * 0.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                        _tabController.animateTo(index);
                      });
                    },
                    isScrollable: true,
                    indicatorColor: AppColors.darkBlue,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3.0,
                    physics: const NeverScrollableScrollPhysics(),
                    tabs: List.generate(
                      personalTitle.length,
                      (index) => Tab(
                        icon: Text(
                          personalTitle[index],
                          style: AppTextStyles.lightTextTheme.subtitle1?.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  )
                ],
              ),
            ),
            FadeIndexedStack(
              index: _selectedIndex,
              children: [
                ...List.generate(
                  3,
                  (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Playlist',
                          style: AppTextStyles.lightTextTheme.headline5?.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      CreatePlaylistCard(onTap: () {}),
                      ...List.generate(
                        personalPlaylists.length,
                        (index) => PlaylistCard(
                          onTap: () {},
                          playlist: personalPlaylists[index],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Suggested playlist',
                          style: AppTextStyles.lightTextTheme.headline5?.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...List.generate(
                        personalSuggestPlaylists.length,
                        (index) => PlaylistCard(
                          playlist: personalSuggestPlaylists[index],
                          onTap: () {},
                          hasFavourite: true,
                          onFavouriteTap: () {},
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
