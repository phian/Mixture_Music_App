import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';

import '../constants/app_colors.dart';
import '../constants/enums/enums.dart';
import '../controllers/auth_controller.dart';
import '../images/app_icons.dart';
import '../routing/routes.dart';
import '../widgets/base_button.dart';
import '../widgets/inkwell_wrapper.dart';
import '../widgets/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          height: MediaQuery.of(context).size.height,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  'SIGN IN',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 64.0),
                CustomTextField(
                  textFieldType: TextFieldType.email,
                  onChanged: (value) {},
                  decorationConfig: TextFieldDecorationConfig(
                    hintText: 'Enter your email or user name',
                    hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                          color: AppColors.c7A7C81,
                          fontSize: 14.0,
                        ),
                  ),
                ),
                const SizedBox(height: 32.0),
                CustomTextField(
                  textFieldType: TextFieldType.password,
                  decorationConfig: TextFieldDecorationConfig(
                    hintText: 'Enter your password',
                    hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                          color: AppColors.c7A7C81,
                          fontSize: 14.0,
                        ),
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 32.0),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWellWrapper(
                        onTap: () {
                          Get.toNamed(AppRoutes.forgotPassword);
                        },
                        color: AppColors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              //color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                BaseButton(
                  content: 'SIGN IN',
                  buttonRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    Get.offAllNamed(AppRoutes.navigationScreen);
                  },
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Or connect with',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SignInButton(
                          signInType: SignInType.facebook,
                          buttonColor: AppColors.white,
                          child: SvgPicture.asset(
                            AppIcons.facebook,
                            alignment: Alignment.center,
                            width: 50.0,
                            height: 50.0,
                          ),
                          onTap: () async {
                            await _authController.signInWithFacebook();
                            var userModel = await _authController.getFacebookUSerData();
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 24.0),
                          child: SignInButton(
                            signInType: SignInType.google,
                            buttonColor: AppColors.white,
                            child: SvgPicture.asset(
                              AppIcons.google,
                              alignment: Alignment.center,
                              width: 50.0,
                              height: 50.0,
                            ),
                            onTap: () {
                              _authController.signInWithGoogle();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          //color: AppColors.white,
                        ),
                      ),
                      InkWellWrapper(
                        onTap: () {
                          Get.toNamed(AppRoutes.signUp);
                        },
                        color: AppColors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
