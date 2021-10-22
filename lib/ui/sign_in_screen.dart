import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/enums/enums.dart';
import '../controllers/auth_controller.dart';
import '../images/app_icons.dart';
import '../routing/routes.dart';
import '../widgets/base_button.dart';
import '../widgets/base_textfield.dart';
import '../widgets/inkwell_wrapper.dart';
import '../widgets/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Text(
                "SIGN IN",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 64.0),
              BaseTextField(
                textFieldType: TextFieldType.email,
                onChanged: (value) {},
              ),
              const SizedBox(height: 32.0),
              BaseTextField(
                textFieldType: TextFieldType.password,
                onChanged: (value) {},
              ),
              const SizedBox(height: 32.0),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWellWrapper(
                      onTap: () {
                        Get.toNamed(AppRoutes.forgotPassword);
                      },
                      color: AppColors.transparent,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              BaseButton(
                content: "SIGN IN",
                onTap: () {
                  Get.toNamed(AppRoutes.navigationScreen);
                },
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  const Expanded(
                    child: const Text(
                      "Or connect with",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton(
                        signInType: SignInType.facebook,
                        buttonColor: AppColors.white,
                        child: SvgPicture.asset(
                          AppIcons.facebook,
                          alignment: Alignment.center,
                          width: 50.0,
                          height: 50.0,
                        ),
                        onTap: () async {
                          await _authController.signInWithFacebook();
                          var userModel = await _authController.getFacebookUSerData();
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 24.0),
                        child: SignInButton(
                          signInType: SignInType.google,
                          buttonColor: AppColors.white,
                          child: SvgPicture.asset(
                            AppIcons.google,
                            alignment: Alignment.center,
                            width: 50.0,
                            height: 50.0,
                          ),
                          onTap: () {
                            _authController.signInWithGoogle();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
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
                        Get.toNamed(AppRoutes.signUp);
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
                            text: "Sign Up",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
