import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/controllers/auth_controller.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/textfield_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:mixture_music_app/widgets/rounded_inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/unfocus_widget.dart';

import '../constants/enums/enums.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/base_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();
  final _userNameController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        //backgroundColor: AppColors.backgroundColor,
        appBar: BaseAppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          leading: Transform.translate(
            offset: const Offset(8.0, 0.0),
            child: RoundedInkWellWrapper(
              onTap: () => Get.back(),
              child: Container(
                child: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                padding: const EdgeInsets.only(left: 8.0),
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _forgotPasswordFormKey,
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
                  Text(
                    'Please fill the information below to change your password',
                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 32.0),
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
                      filled: true,
                      fillColor: AppColors.black12.withOpacity(0.02),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        textFieldConfig: TextFieldConfig(
                          controller: _newPasswordController,
                          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                        decorationConfig: TextFieldDecorationConfig(
                          hintText: 'New password',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.c7A7C81.withOpacity(0.6)),
                          filled: true,
                          fillColor: AppColors.black12.withOpacity(0.02),
                        ),
                        textFieldType: TextFieldType.password,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Password must contain at least 6 characters, 1 uppercase, 1 lower case, 1 number and 1 special character',
                        style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64.0),
                  BaseButton(
                    content: 'SUBMIT',
                    onTap: () async {
                      if (_forgotPasswordFormKey.currentState?.validate() == true) {
                        var res = await _authController.getUserByID(_userNameController.text);

                        if (res != null) {
                          if (_newPasswordController.text == res.password) {
                            Fluttertoast.showToast(
                              msg: 'New password is the same with your old password',
                              fontSize: 18.0,
                              backgroundColor: AppColors.cFF4C4E,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          } else {
                            await _authController.resetAccountPassword(_userNameController.text, _newPasswordController.text);
                            Fluttertoast.showToast(
                              msg: 'Update success',
                              fontSize: 18.0,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Theme.of(context).primaryColor,
                            );
                            Get.back();
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
                    },
                    buttonRadius: BorderRadius.circular(8.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
