import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class PickImageDialog extends StatelessWidget {
  const PickImageDialog({
    Key? key,
    required this.onCameraTap,
    required this.onGalleryTap,
  }) : super(key: key);
  final void Function() onGalleryTap;
  final void Function() onCameraTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose a source',
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16.0),
            IntrinsicHeight(
              child: Row(
                children: [
                  DialogButton(
                    title: 'Gallery',
                    source: ImageSource.gallery,
                    onDialogButtonTap: onGalleryTap,
                  ),
                  Container(
                    // height: 50.0,
                    width: 0.5,
                    color: AppColors.c7A7C81,
                  ).paddingSymmetric(vertical: 16),
                  DialogButton(
                    title: 'Camera',
                    source: ImageSource.camera,
                    onDialogButtonTap: onCameraTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    Key? key,
    required this.title,
    this.borderRadius,
    required this.source,
    required this.onDialogButtonTap,
  }) : super(key: key);
  final String title;
  final BorderRadius? borderRadius;
  final ImageSource source;
  final void Function() onDialogButtonTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWellWrapper(
        onTap: onDialogButtonTap,
        color: AppColors.white,
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          child: Column(
            children: [
              Icon(
                source == ImageSource.camera ? Icons.camera_alt_outlined : Icons.photo,
                color: Theme.of(context).primaryColor,
              ).marginOnly(bottom: 4.0),
              Text(
                title,
                style: Theme.of(context).textTheme.button,
              ),
              // title.s14w400(color: AppColors.c7E7E7E),
            ],
          ),
        ),
      ),
    );
  }
}
