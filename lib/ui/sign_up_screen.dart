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
                  Text(
                    "SIGN UP",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
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
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
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
