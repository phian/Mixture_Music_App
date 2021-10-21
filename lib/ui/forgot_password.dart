import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/enums/enums.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/base_button.dart';
import '../widgets/base_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BaseAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Forgot Password?",
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Please fill the information below to change your password",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 32.0),
              BaseTextField(
                textFieldType: TextFieldType.email,
                onChanged: (value) {},
              ),
              const SizedBox(height: 32.0),
              BaseTextField(
                hintText: "New Password",
                textFieldType: TextFieldType.password,
                onChanged: (value) {},
              ),
              const SizedBox(height: 64.0),
              BaseButton(
                content: "SUBMIT",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
