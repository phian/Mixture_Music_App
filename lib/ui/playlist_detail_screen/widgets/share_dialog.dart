import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({
    Key? key,
    required this.playlistId,
    required this.playListName,
    this.playlistNameStyle,
    this.contentPadding,
    this.subtitleStyle,
    this.titleStyle,
  }) : super(key: key);

  final String playlistId;
  final String playListName;
  final TextStyle? playlistNameStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? subtitleStyle;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: contentPadding ?? EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Mixture Music', style: titleStyle),
            const SizedBox(height: 8.0),
            Text('Scan this QR code to get the playlist', style: subtitleStyle, textAlign: TextAlign.center),
            const SizedBox(height: 16.0),
            QrImage(
              data: playlistId,
              version: QrVersions.auto,
              size: 250.0,
            ),
            const SizedBox(height: 12.0),
            Text(playListName, style: playlistNameStyle),
          ],
        ),
      ),
    );
  }
}
