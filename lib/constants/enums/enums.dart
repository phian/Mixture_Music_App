enum SignInType {
  facebook,
  google,
  authUser,
}

enum TextFieldType {
  name,
  email,
  password,
  phoneNumber,
  multiline,
}

enum ViewType {
  grid,
  list,
}

enum FeedbackType {
  bugReport,
  productFeedback,
  contentReleaseFeedback,
  contentCooperationFeedback,
  anotherProblem,
}

enum CreateAccountState {
  success,
  failed,
  emailAlreadyUsed,
}

enum SignInAccountState {
  success,
  notFound,
  failed,
  wrongPassword,
}