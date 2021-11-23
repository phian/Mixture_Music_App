import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';

import '../constants/app_colors.dart';
import '../constants/enums/enums.dart';
import '../widgets/base_button.dart';
import '../widgets/inkwell_wrapper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Text(
                      'SIGN UP',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 64.0),
                    Wrap(
                      runSpacing: 32.0,
                      children: [
                        CustomTextField(
                          textFieldType: TextFieldType.name,
                          onChanged: (value) {},
                          decorationConfig: TextFieldDecorationConfig(
                            hintText: 'Enter your email or user name',
                            hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                                  color: AppColors.c7A7C81,
                                  fontSize: 14.0,
                                ),
                          ),
                        ),
                        CustomTextField(
                          textFieldType: TextFieldType.email,
                          onChanged: (value) {},
                          decorationConfig: TextFieldDecorationConfig(
                            hintText: 'Enter your password',
                            hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                                  color: AppColors.c7A7C81,
                                  fontSize: 14.0,
                                ),
                          ),
                        ),
                        CustomTextField(
                          textFieldType: TextFieldType.password,
                          onChanged: (value) {},
                          decorationConfig: TextFieldDecorationConfig(
                            hintText: 'Re-enter your password',
                            hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                                  color: AppColors.c7A7C81,
                                  fontSize: 14.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 64.0),
                    BaseButton(
                      content: 'SIGN UP',
                      onTap: () {},
                      buttonRadius: BorderRadius.circular(8.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWellWrapper(
                    onTap: () {
                      Get.back();
                    },
                    color: AppColors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor,
                          ),
                          text: 'Sign In',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
