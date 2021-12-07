import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/ui/settings_screen/controller/setings_screen_controller.dart';
import 'package:mixture_music_app/widgets/bottom_sheet_wrapper.dart';

class NotificationSheet extends StatelessWidget {
  const NotificationSheet({
    Key? key,
    required this.controller,
    this.onDarkModeChanged,
    required this.title,
  }) : super(key: key);

  final SettingsScreenController controller;
  final void Function(bool value)? onDarkModeChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      titlePadding: const EdgeInsets.symmetric(vertical: 12.0),
      contentItems: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Allow notification',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              Obx(
                () => Switch.adaptive(
                  value: controller.darkMode.value,
                  onChanged: (value) {
                    controller.onDarkModeChanged(value);
                    onDarkModeChanged?.call(value);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
