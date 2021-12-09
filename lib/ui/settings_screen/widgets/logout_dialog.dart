import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/images/app_images.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key, this.onCancelButtonTap, this.onDeleteButtonTap}) : super(key: key);

  final void Function()? onDeleteButtonTap;
  final void Function()? onCancelButtonTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.logout, width: 100.0, height: 100.0),
            const SizedBox(height: 16.0),
            Text(
              'Are you sure you want to sign out?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWellWrapper(
                    onTap: onCancelButtonTap,
                    color: AppColors.c7A7C81.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: InkWellWrapper(
                    onTap: onDeleteButtonTap,
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Sign Out',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
