import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mixture_music_app/constants/app_colors.dart';

class LoadingOverLayWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverLayWidget({Key? key, required this.isLoading, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (isLoading) ...[
          Container(
            color: Colors.black.withOpacity(0.03),
          ),
          SpinKitFadingCube(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? AppColors.c7A7C81 : Theme.of(context).primaryColor,
                ),
              );
            },
          )
        ],
      ],
    );
  }
}
