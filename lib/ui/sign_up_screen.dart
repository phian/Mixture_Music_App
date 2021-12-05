import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/auth_controller.dart';
import 'package:mixture_music_app/utils/extensions.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/textfield_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:mixture_music_app/widgets/unfocus_widget.dart';

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
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _signUpFormKey,
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextField(
                                textFieldType: TextFieldType.password,
                                onChanged: (value) {},
                                textFieldConfig: TextFieldConfig(
                                  controller: _passwordController,
                                  style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                                  validator: (value) {
                                    if (_passwordController.text.trim() != _confirmPasswordController.text) {
                                      return 'Password and confirm password is not the same';
                                    } else if (value != null) {
                                      return value.validatePassword();
                                    }
                                  },
                                ),
                                decorationConfig: TextFieldDecorationConfig(
                                  hintText: 'Enter your password',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.c7A7C81.withOpacity(0.6)),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Password must contain at least 6 characters, 1 uppercase, 1 lower case, 1 number and 1 special character',
                                style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14.0),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextField(
                                textFieldType: TextFieldType.password,
                                onChanged: (value) {},
                                textFieldConfig: TextFieldConfig(
                                  controller: _confirmPasswordController,
                                  style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                                  validator: (value) {
                                    if (_passwordController.text.trim() != _confirmPasswordController.text) {
                                      return 'Password and confirm password is not the same';
                                    } else if (value != null) {
                                      return value.validatePassword();
                                    }
                                  },
                                ),
                                decorationConfig: TextFieldDecorationConfig(
                                  hintText: 'Re-enter your password',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.c7A7C81.withOpacity(0.6)),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Password must contain at least 6 characters, 1 uppercase, 1 lower case, 1 number and 1 special character',
                                style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 64.0),
                      BaseButton(
                        content: 'SIGN UP',
                        onTap: () async {
                          if (primaryFocus != null) {
                            primaryFocus!.unfocus();
                          }

                          if (_signUpFormKey.currentState?.validate() == true) {
                            print(_userNameController.text);
                            _authController.checkIfUserExisted(_userNameController.text).then((value) async {
                              print(value);

                              if (!value) {
                                await _authController.addUser(userName: _userNameController.text.trim(), password: _passwordController.text.trim());
                                Fluttertoast.showToast(
                                  msg: 'Create account success',
                                  fontSize: 18.0,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Theme.of(context).primaryColor,
                                );
                                Get.back();
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Account is already existed',
                                  fontSize: 18.0,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Theme.of(context).primaryColor,
                                );
                              }
                            });
                          }
                        },
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
      ),
    );
  }
}
