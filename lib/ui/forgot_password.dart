import 'package:flutter/material.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';

import '../constants/enums/enums.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/base_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.backgroundColor,
      appBar: const BaseAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 30,
                      ),
                ),
                const SizedBox(height: 32.0),
                const Text(
                  'Please fill the information below to change your password',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    //color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 32.0),
                CustomTextField(
                  textFieldType: TextFieldType.email,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 32.0),
                CustomTextField(
                  decorationConfig: const TextFieldDecorationConfig(
                    hintText: 'New password',
                  ),
                  textFieldType: TextFieldType.password,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 64.0),
                BaseButton(
                  content: 'SUBMIT',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
