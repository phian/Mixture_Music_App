import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/controllers/auth_controller.dart';
import 'package:mixture_music_app/images/app_icons.dart';
import 'package:mixture_music_app/models/auth/auth_user_model.dart';
import 'package:mixture_music_app/ui/edit_profile_screen/widgets/pick_image_dialog.dart';
import 'package:mixture_music_app/widgets/base_app_bar.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/textfield_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/unfocus_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  bool _isEnableSave = false;
  AuthUserModel _authUser = AuthUserModel();
  final _authController = Get.find<AuthController>();
  File? _avatar;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _authUser = (Get.arguments as AuthUserModel);
    _getUserName();
  }

  void _getUserName() async {
    _userName = await _authController.getAuthUserName();
    setState(() {
      _nameController.text = _userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: BaseAppBar(
          title: Text(
            'Edit profile',
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
              Get.back(result: true);
            },
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: InkWellWrapper(
                  onTap: _isEnableSave
                      ? () async {
                          String url = '';
                          if (_avatar != null) {
                            url = await _authController.uploadAvatarToFirebase(_avatar!);
                            await _authController.updateAuthUserAvatar(url);
                          }
                          var temp = await _authController.getUserByUserName(_userName);
                          await _authController.updateAuthUserData(
                            _userName,
                            _nameController.text,
                            url.isNotEmpty
                                ? url
                                : _authUser.avatarUrl?.isNotEmpty == true
                                    ? _authUser.avatarUrl!
                                    : '',
                            temp?.password ?? '',
                          );
                          if (_userName != _nameController.text) {
                            await _authController.updateAuthUserName(_nameController.text);
                            _getUserName();
                            _isEnableSave = false;
                          }
                          Fluttertoast.showToast(
                            msg: 'Update profile success',
                            fontSize: 18.0,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Theme.of(context).primaryColor,
                          );
                        }
                      : null,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontSize: 20.0,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        child: PickImageDialog(
                          onCameraTap: () {
                            Get.back();
                            _pickImage(ImageSource.camera);
                          },
                          onGalleryTap: () {
                            Get.back();
                            _pickImage(ImageSource.gallery);
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
                        child: () {
                          if (_avatar != null) {
                            return Image.file(
                              _avatar!,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              fit: BoxFit.cover,
                            );
                          }

                          if (_authUser!.avatarUrl != null) {
                            return Image.network(
                              _authUser.avatarUrl!,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              fit: BoxFit.cover,
                            );
                          } else {
                            Image.asset(
                              AppIcons.avatar,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              fit: BoxFit.cover,
                            );
                          }
                        }(),
                      ),
                      Icon(Icons.camera_enhance, size: 35.0, color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Change avatar',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
              ),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  textFieldType: TextFieldType.name,
                  textFieldConfig: TextFieldConfig(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    controller: _nameController,
                  ),
                  onChanged: (value) {
                    if ((value.trim() != _userName && _nameController.text.isNotEmpty) || _avatar != null) {
                      setState(() {
                        _isEnableSave = true;
                      });
                    } else {
                      _isEnableSave = false;
                    }
                  },
                  decorationConfig: TextFieldDecorationConfig(
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 0.1)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 0.1)),
                    border: const UnderlineInputBorder(borderSide: BorderSide(width: 0.1)),
                    hintText: 'Your name',
                    hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'This is maybe your name or nickname.\nThis is how you appear on our app',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
    setState(() {
      _isEnableSave = true;
    });
  }
}
