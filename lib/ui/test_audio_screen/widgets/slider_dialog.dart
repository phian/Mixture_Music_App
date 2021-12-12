import 'package:flutter/material.dart';

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                style: const TextStyle(fontFamily: 'Fixed', fontWeight: FontWeight.bold, fontSize: 24.0)),
            Slider(
              divisions: divisions,
              min: min,
              max: max,
              value: snapshot.data ?? value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    ),
  );
}
