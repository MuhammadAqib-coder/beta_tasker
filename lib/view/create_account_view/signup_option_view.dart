import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/round_button.dart';
import 'package:beta_tasker/images/icons/icon_image.dart';
import 'package:beta_tasker/images/splash_image/splash_image.dart';
import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:beta_tasker/view/create_account_view/signUp_email_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupOptionView extends StatefulWidget {
  const SignupOptionView({Key? key}) : super(key: key);

  @override
  State<SignupOptionView> createState() => _SignupOptionViewState();
}

class _SignupOptionViewState extends State<SignupOptionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 50.h,
          left: 18.w,
          right: 18.w,
        ),
        child: Column(children: [
          Image.asset(
            SplashImage.splash,
            height: 130.h,
          ),
          FixHeightWidth.height26,
          CustomText(
              text: "Beta Tasker",
              fontSize: 25.sm,
              fontWeight: FontWeight.w800,
              style: 'gilroy'),
          SizedBox(
            height: 40.h,
          ),
          RoundButton(
              image: IconImage.googleIcon,
              title: 'SignUp with Google',
              color: AppColors.whiteColor,
              textColor: AppColors.blackColor,
              shadowColor: AppColors.whiteSmokeColor,
              onPressed: () {}),
          FixHeightWidth.height12,
          RoundButton(
              image: IconImage.fbIcon,
              title: 'SignUp with Facebook',
              color: AppColors.whiteColor,
              textColor: AppColors.blackColor,
              shadowColor: AppColors.whiteSmokeColor,
              onPressed: () {}),
          FixHeightWidth.height12,
          RoundButton(
              image: IconImage.appleIcon,
              title: 'SignUp with Apple',
              color: AppColors.whiteColor,
              textColor: AppColors.blackColor,
              shadowColor: AppColors.whiteSmokeColor,
              onPressed: () {}),
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 2,
                color: Colors.black26,
                width: 150.w,
              ),
              const Text('or'),
              Container(
                height: 2,
                color: Colors.black26,
                width: 150.w,
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          RoundButton(
              color: AppColors.blueColor,
              shadowColor: AppColors.roundButtonShadowColor,
              textColor: AppColors.whiteColor,
              title: 'SignUp With Email',
              onPressed: () {
                Navigator.pushNamed(
                    context, RoutesName.signupEmailPasswordView);
              }),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  color: AppColors.noAccountColor,
                  text: 'Already have an account?',
                  fontSize: 15.sm,
                  fontWeight: FontWeight.w500),
              TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, RoutesName.signinView);
                  },
                  child: CustomText(
                    text: 'SignIn',
                    fontSize: 15.sm,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ]),
      ),
    );
  }
}
