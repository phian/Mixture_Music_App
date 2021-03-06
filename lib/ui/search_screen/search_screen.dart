import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/search_screen/controller/search_controller.dart';
import 'package:mixture_music_app/ui/search_screen/real_search_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Search',
                      style: theme.textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.scanQrCode);
                    },
                    icon: const Icon(Icons.camera_enhance_outlined),
                    iconSize: 27.0,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Get.to(() => const RealSearchScreen());
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.brightness == Brightness.light ? Colors.grey[200] : Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 8.0),
                      Text(
                        'Search Songs, Artist',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontSize: 16.0,
                              color: AppColors.hintColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Recent',
                style: theme.textTheme.headline6,
              ),
              const SizedBox(height: 16),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (int i = 0; i < controller.limitLengthRecentSearch(); i++)
                      GestureDetector(
                        onTap: () {
                          Get.to(() => RealSearchScreen(searchKeyWord: controller.listRecentSearch[i]));
                        },
                        child: Chip(
                          label: Text(controller.listRecentSearch[i]),
                          deleteIcon: Icon(
                            Icons.close,
                            color: theme.iconTheme.color!.withOpacity(0.5),
                          ),
                          onDeleted: () {
                            controller.removeSearch(i);
                            controller.saveRecentSearchToHive();
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
