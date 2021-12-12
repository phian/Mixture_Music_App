import 'package:flutter/material.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/custom_audio_handler.dart';

class CustomAudioServiceWidget extends StatefulWidget {
  final Widget child;

  final CustomAudioHandler audioHandler;

  const CustomAudioServiceWidget({Key? key, required this.child, required this.audioHandler}) : super(key: key);

  @override
  _CustomAudioServiceWidgetState createState() => _CustomAudioServiceWidgetState();
}

class _CustomAudioServiceWidgetState extends State<CustomAudioServiceWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    // widget.audioHandler.init();
    // AudioService.connect();
  }

  @override
  void dispose() {
    // AudioService.disconnect();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // AudioService.connect();
        break;
      case AppLifecycleState.paused:
        // AudioService.disconnect();
        break;
      case AppLifecycleState.detached:
        // widget.audioHandler.stop();
        break;
      default:
        break;
    }
  }

  @override
  Future<bool> didPopRoute() async {
    // AudioService.disconnect();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
