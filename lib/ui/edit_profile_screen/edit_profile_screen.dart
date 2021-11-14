import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
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
  bool _isEnableSave = true;

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
              Get.back();
            },
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: InkWellWrapper(
                  onTap: _isEnableSave ? () {} : null,
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
                child: ClipOval(
                  child: GestureDetector(
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          child: PickImageDialog(
                            onCameraTap: () {
                              _pickImage(ImageSource.camera);
                            },
                            onGalleryTap: () {
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        barrierColor: Colors.transparent,
                      );
                    },
                    child: Image.network(
                      'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.cover,
                    ),
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
                    if (value.isNotEmpty && _isEnableSave == false) {
                      setState(() {
                        _isEnableSave = true;
                      });
                    } else if (value.isEmpty && _isEnableSave == true) {
                      setState(() {
                        _isEnableSave = false;
                      });
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

  Future<XFile?> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: source);

    return result;
  }
}
