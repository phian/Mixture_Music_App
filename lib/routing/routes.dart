class AppRoutes {
  static const splash = '/splash';
  static const onBoarding = '/on_boarding';
  static const main = '/main';
  static const signIn = '$onBoarding/sign_in';
  static const signUp = '$signIn/sign_up';
  static const forgotPassword = '$signIn/forgot_password';
  static const navigationScreen = '/navigation_screen';
  static const musicPlayerScreen = '/play_screen';
  static const settingsScreen = '/personal_info/settings_screen';
  static const feedbackAndBugReport = '$settingsScreen/feedback-and-bug-report';
}
