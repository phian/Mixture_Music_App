import 'package:mixture_music_app/constants/validator_patterns.dart';

extension StringExtension on String {
  String? validateEmail() {
    if (this == null) {
      return 'Email is not valid!';
    } else {
      if (isEmpty) {
        return 'Email is not valid!';
      }
    }

    String pattern = VerifyTextFieldRegex.emailPattern;
    var result = RegExp(pattern).hasMatch(this);
    if (result) {
      return null;
    } else {
      return 'Email is not valid!';
    }
  }

  String? validatePhoneNumber() {
    if (this == null) {
      return 'Phone is not valid!';
    } else {
      if (isEmpty) {
        return 'Phone is not valid!';
      }
    }

    String pattern = VerifyTextFieldRegex.phoneNumberPattern;
    var result = RegExp(pattern).hasMatch(this);
    if (result) {
      return null;
    } else {
      return 'Phone is not valid!';
    }
  }

  String? validateName() {
    if (this == null) {
      return 'Name is not valid!';
    } else {
      if (isEmpty) {
        return 'Name is not valid!';
      }
    }
  }

  String? validatePassword() {
    if (this == null) {
      return 'Password is not valid!';
    } else {
      if (isEmpty) {
        return 'Password is not valid!';
      }
    }
  }
}
