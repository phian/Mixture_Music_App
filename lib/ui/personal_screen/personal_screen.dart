import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/models/facebook/facebook_user_model.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/personal_screen/view/mix_music_view.dart';
import 'package:mixture_music_app/ui/personal_screen/view/playlist_view.dart';
import 'package:mixture_music_app/ui/personal_screen/view/recent_activity_view.dart';
import 'package:mixture_music_app/ui/personal_screen/widgets/grid_card.dart';
import 'package:mixture_music_app/widgets/fade_indexed_stack.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key, required this.userModel}) : super(key: key);
  final FacebookUserModel userModel;

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 16.0),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Personal Info',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: 30.0,
                            color: AppColors.black,
                          ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.settingsScreen);
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            InkWellWrapper(
              color: Colors.transparent,
              onTap: () {},
              borderRadius: BorderRadius.zero,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.userModel.name!,
                            style: Theme.of(context).textTheme.headline5?.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            widget.userModel.email!,
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Align(
                        child: Icon(Icons.arrow_forward_ios, size: 20.0),
                        alignment: Alignment.centerRight,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Library',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
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
                                    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
              padding: const EdgeInsets.only(left: 8.0, top: 24.0),
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
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
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
                  (index) => index == 0
                      ? PlaylistView(
                          suggestedPlaylist: personalSuggestPlaylists,
                        )
                      : index == 1
                          ? const MixMusicView()
                          : const RecentActivityView(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
