import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/textfield_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:mixture_music_app/widgets/unfocus_widget.dart';

import '../../constants/app_colors.dart';
import '../../constants/enums/enums.dart';
import '../../controllers/auth_controller.dart';
import '../../images/app_icons.dart';
import '../../routing/routes.dart';
import '../../widgets/base_button.dart';
import '../../widgets/inkwell_wrapper.dart';
import '../../widgets/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();
  String? _validateText;

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _signInFormKey,
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
                    textFieldConfig: TextFieldConfig(
                      controller: _userNameController,
                      style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                    decorationConfig: TextFieldDecorationConfig(
                      hintText: 'Enter your email',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.c7A7C81.withOpacity(0.6)),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        textFieldType: TextFieldType.password,
                        textFieldConfig: TextFieldConfig(
                          controller: _passwordController,
                          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                        decorationConfig: TextFieldDecorationConfig(
                          hintText: 'Enter your password',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.c7A7C81.withOpacity(0.6)),
                        ),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Password must contain at least 6 characters, 1 uppercase, 1 lower case, 1 number and 1 special character',
                        style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              //color: AppColors.white,
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.forgotPassword);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  BaseButton(
                    content: 'SIGN IN',
                    buttonRadius: BorderRadius.circular(8.0),
                    onTap: () async {
                      if (primaryFocus != null) {
                        primaryFocus!.unfocus();
                      }

                      if (_signInFormKey.currentState?.validate() == true) {
                        _checkUserDataAndNavigateScreen();
                      }
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
                              var loginResult = await _authController.signInWithFacebook();

                              if (loginResult != null) {
                                switch (loginResult.status) {
                                  case LoginStatus.success:
                                    Fluttertoast.showToast(
                                      msg: 'Login success',
                                      fontSize: 18.0,
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: Theme.of(context).primaryColor,
                                    );
                                    Get.offAllNamed(AppRoutes.navigationScreen);
                                    break;
                                  case LoginStatus.cancelled:
                                    Fluttertoast.showToast(
                                      msg: 'Login cancelled',
                                      fontSize: 18.0,
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: Theme.of(context).primaryColor,
                                    );
                                    break;
                                  case LoginStatus.failed:
                                    Fluttertoast.showToast(
                                      msg: 'Login error',
                                      fontSize: 18.0,
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: Theme.of(context).primaryColor,
                                    );
                                    break;
                                  case LoginStatus.operationInProgress:
                                    break;
                                }
                              }
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
                              onTap: () async {
                                var user = await _authController.signInWithGoogle();
                                if (user != null) {
                                  Get.offAllNamed(AppRoutes.navigationScreen);
                                }
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
                                fontWeight: FontWeight.w500,
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
      ),
    );
  }

  void _checkUserDataAndNavigateScreen() async {
    var user = await _authController.getUserByUserName(_userNameController.text);
    if (user != null) {
      if (_userNameController.text == user.userName && _passwordController.text == user.password) {
        Fluttertoast.showToast(
          msg: 'Login success',
          fontSize: 18.0,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Theme.of(context).primaryColor,
        );
        Get.offAllNamed(AppRoutes.navigationScreen);
      }
      if (_userNameController.text == user.userName && _passwordController.text != user.password) {
        Fluttertoast.showToast(
          msg: 'Password is not correct',
          fontSize: 18.0,
          backgroundColor: AppColors.cFF4C4E,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Email is not existed',
        fontSize: 18.0,
        backgroundColor: AppColors.cFF4C4E,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
