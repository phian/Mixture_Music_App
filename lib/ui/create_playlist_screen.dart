import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePlaylistScreen extends StatelessWidget {
  const CreatePlaylistScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Material(
        child: SizedBox(
          height: Get.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text(
                  'Give your playlist a name',
                  style: theme.textTheme.headline5,
                ),
                const SizedBox(height: 50),
                TextField(
                  style: theme.textTheme.headline3,
                  autofocus: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                CupertinoButton(
                  onPressed: () {
                    Get.back();
                  },
                  borderRadius: BorderRadius.circular(30),
                  color: theme.primaryColor,
                  child: Text(
                    'Create',
                    style: theme.textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
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
