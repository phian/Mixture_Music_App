import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/enums/enums.dart';
import '../widgets/base_button.dart';
import '../widgets/base_textfield.dart';
import '../widgets/inkwell_wrapper.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 64.0),
                  Wrap(
                    runSpacing: 32.0,
                    children: [
                      BaseTextField(
                        textFieldType: TextFieldType.name,
                        onChanged: (value) {},
                      ),
                      BaseTextField(
                        textFieldType: TextFieldType.email,
                        onChanged: (value) {},
                      ),
                      BaseTextField(
                        textFieldType: TextFieldType.password,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 64.0),
                  BaseButton(
                    content: "SIGN UP",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
                InkWellWrapper(
                  onTap: () {
                    Get.back();
                  },
                  color: AppColors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.cEF01A0,
                        ),
                        text: "Sign In",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
