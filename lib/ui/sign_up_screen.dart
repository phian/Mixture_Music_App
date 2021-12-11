import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mixture_music_app/controllers/auth_controller.dart';
import 'package:mixture_music_app/images/app_icons.dart';
import 'package:mixture_music_app/ui/edit_profile_screen/widgets/pick_image_dialog.dart';
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
  File? _avatar;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: source);

    if (result != null) {
      _cropImage(result.path);
    }
  }

  Future<void> _cropImage(String path) async {
    _avatar = await ImageCropper.cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop your avatar',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Text(
                    'SIGN UP',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            child: PickImageDialog(
                              onCameraTap: () {
                                _pickImage(ImageSource.camera);
                                Get.back();
                              },
                              onGalleryTap: () {
                                _pickImage(ImageSource.gallery);
                                Get.back();
                              },
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          barrierColor: Colors.transparent,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: _avatar == null
                                ? Image.asset(
                                    AppIcons.avatar,
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.width * 0.4,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    _avatar!,
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.width * 0.4,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Icon(Icons.camera_enhance, size: 35.0, color: Theme.of(context).primaryColor),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
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
                        String avatarUrl = '';
                        if (_avatar != null) {
                          avatarUrl = await _authController.uploadAvatarToFirebase(_avatar!);
                        }

                        var result = await _authController
                            .createAuthUser(userName: _userNameController.text, password: _passwordController.text, avatarUrl: avatarUrl)
                            .catchError(
                          (err) {
                            print(err);
                          },
                        );

                        switch (result) {
                          case CreateAccountState.success:
                            Fluttertoast.showToast(
                              msg: 'Create account success',
                              fontSize: 18.0,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Theme.of(context).primaryColor,
                            );
                            Get.back();
                            break;
                          case CreateAccountState.failed:
                            Fluttertoast.showToast(
                              msg: 'Create account failed',
                              fontSize: 18.0,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Theme.of(context).primaryColor,
                            );
                            break;
                          case CreateAccountState.emailAlreadyUsed:
                            Fluttertoast.showToast(
                              msg: 'Account is already existed',
                              fontSize: 18.0,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Theme.of(context).primaryColor,
                            );
                            break;
                        }
                      }
                    },
                    buttonRadius: BorderRadius.circular(8.0),
                  ),
                  const SizedBox(height: 32.0),
                  Row(
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
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
