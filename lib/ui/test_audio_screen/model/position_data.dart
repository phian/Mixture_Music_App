class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration? duration;

  PositionData({required this.position, required this.bufferedPosition, this.duration});
}
