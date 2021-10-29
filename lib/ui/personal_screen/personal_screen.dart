import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_text_style.dart';
import '../../models/facebook/facebook_user_model.dart';
import 'widgets/grid_card.dart';

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
                        Expanded(
                          child: Row(
                            children: [
                              ...List.generate(
                                3,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: GridCard(
                                    cardIcon: accountScreenGridIcon[index],
                                    cardTitle: accountScreenGridData[index],
                                    iconColor: accountScreenIconColors[index],
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              ...List.generate(
                                3,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: GridCard(
                                    cardIcon: accountScreenGridIcon[index + 3],
                                    cardTitle: accountScreenGridData[index + 3],
                                    iconColor:
                                        accountScreenIconColors[index + 3],
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
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
            const SizedBox(height: 24.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Suggest playlist',
                style: AppTextStyles.lightTextTheme.headline5?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
