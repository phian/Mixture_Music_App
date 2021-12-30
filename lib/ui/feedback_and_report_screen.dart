import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/images/app_icons.dart';
import 'package:mixture_music_app/images/app_images.dart';
import 'package:mixture_music_app/utils/extensions.dart';
import 'package:mixture_music_app/widgets/base_app_bar.dart';
import 'package:mixture_music_app/widgets/base_button.dart';
import 'package:mixture_music_app/widgets/custom_dropdown/config/dropdown_style.dart';
import 'package:mixture_music_app/widgets/custom_dropdown/custom_dropdown_button.dart';
import 'package:mixture_music_app/widgets/custom_dropdown/widgets/dropdown_item.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/textfield_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:mixture_music_app/widgets/unfocus_widget.dart';

class FeedbackAndReportScreen extends StatefulWidget {
  const FeedbackAndReportScreen({Key? key}) : super(key: key);

  @override
  _FeedbackAndReportScreenState createState() => _FeedbackAndReportScreenState();
}

class _FeedbackAndReportScreenState extends State<FeedbackAndReportScreen> {
  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: BaseAppBar(
          title: Text(
            'Feedback / bug report',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontSize: 22.0,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Image.asset(AppIcons.appIcon, width: 80.0, height: 80.0),
                    Container(
                      height: 80.0,
                      width: 2.5,
                      color: AppColors.black12,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    Expanded(
                      child: Text(
                        'Feedback info',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Image.asset(AppImages.feedback),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  child: Column(
                    children: [
                      _FeedbackTitleText(
                        titleContent: 'Select the feedback problem',
                        titleStyle: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CustomDropdown<String>(
                        placeHolderChild: Text(
                          'Select the feedback problem',
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                        ),
                        onChanged: (value, index) {},
                        dropdownStyle: const DropdownStyle(
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                        ),
                        dropdownButtonStyle: const DropdownButtonStyle(
                          buttonHeight: 50.0,
                            shadowColor: Colors.black),
                        items: [
                          ...List.generate(
                            FeedbackType.values.length,
                            (index) => DropdownItem<String>(
                              value: FeedbackType.values[index].getFeedbackText(),
                              child: Text(
                                FeedbackType.values[index].getFeedbackText(),
                                style: Theme.of(context).textTheme.headline5?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _FeedbackTitleText(
                        titleContent: 'Content',
                        titleStyle: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      const CustomTextField(
                        textFieldType: TextFieldType.multiline,
                        textFieldConfig: TextFieldConfig(
                          maxLines: 5,
                        ),
                        decorationConfig: TextFieldDecorationConfig(hintText: 'Enter your feedback here'),
                      ),
                      const SizedBox(height: 16.0),
                      _FeedbackTitleText(
                        titleContent: 'Your full name',
                        titleStyle: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      const CustomTextField(
                        textFieldType: TextFieldType.name,
                      ),
                      const SizedBox(height: 16.0),
                      _FeedbackTitleText(
                        titleContent: 'Email',
                        titleStyle: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      const CustomTextField(
                        textFieldType: TextFieldType.email,
                      ),
                      const SizedBox(height: 16.0),
                      _FeedbackTitleText(
                        titleContent: 'Phone number',
                        titleStyle: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      const CustomTextField(
                        textFieldType: TextFieldType.phoneNumber,
                      ),
                      const SizedBox(height: 48.0),
                      BaseButton(
                        content: 'Send',
                        onTap: () {},
                        contentStyle: Theme.of(context).textTheme.headline5?.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                        buttonRadius: BorderRadius.circular(30.0),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackTitleText extends StatelessWidget {
  const _FeedbackTitleText({
    Key? key,
    required this.titleContent,
    this.titleStyle,
    this.compulsoryCharacterColor,
    this.textAlignment = Alignment.centerLeft,
  }) : super(key: key);

  final String titleContent;
  final TextStyle? titleStyle;
  final Color? compulsoryCharacterColor;
  final Alignment textAlignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: textAlignment,
      child: RichText(
        text: TextSpan(
          text: '$titleContent ',
          style: titleStyle,
          children: [
            TextSpan(
              text: '*',
              style: titleStyle?.copyWith(
                color: compulsoryCharacterColor ?? Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
