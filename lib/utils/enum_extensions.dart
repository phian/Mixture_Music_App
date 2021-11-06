import 'package:mixture_music_app/constants/enums/enums.dart';

extension FeedbackEnumExtension on FeedbackType {
  String getFeedbackText() {
    switch (this) {
      case FeedbackType.bugReport:
        return 'Bug report';
      case FeedbackType.productFeedback:
        return 'Product feedback';
      case FeedbackType.contentReleaseFeedback:
        return 'Content release';
      case FeedbackType.contentCooperationFeedback:
        return 'Content cooperation';
      case FeedbackType.anotherProblem:
        return 'Others';
    }
  }
}
