import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/round_button.dart';
import 'package:beta_tasker/core/common_widgets/round_textfield.dart';
import 'package:beta_tasker/images/icons/icon_image.dart';
import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:beta_tasker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  bool hidePassword = true;
  bool checkboxValue = false;
  var emailControler = TextEditingController();
  var passControler = TextEditingController();
  var emailNode = FocusNode();
  var passNode = FocusNode();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
          title: 'Login To Your Account',
          icon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: AppColors.blackColor,
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 150.h),
        child: Column(
          children: [
            RoundTextField(
                prefixIcon: const Icon(Icons.email_rounded),
                node: emailNode,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, emailNode, passNode);
                },
                hintText: 'Email',
                controller: emailControler),
            FixHeightWidth.height15,
            RoundTextField(
                prefixIcon: Icon(Icons.lock),
                obsecure: hidePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                ),
                node: passNode,
                hintText: 'password',
                controller: passControler),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                  value: checkboxValue,
                  onChanged: (value) {
                    setState(() {
                      checkboxValue = value!;
                    });
                  },
                  side: BorderSide(color: Colors.blue, width: 2.w),
                ),
                const Text('Remember Me'),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            RoundButton(
                title: "SignIn",
                color: AppColors.blueColor,
                textColor: AppColors.whiteColor,
                shadowColor: AppColors.roundButtonShadowColor,
                onPressed: () {
                  Navigator.popAndPushNamed(context, RoutesName.landingView);
                }),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
                onPressed: () {},
                child: CustomText(
                    text: "Forget Password?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 2,
                  color: Colors.black26,
                  width: 105.w,
                ),
                const Text('or continue with'),
                Container(
                  height: 2,
                  color: Colors.black26,
                  width: 105.w,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      IconImage.fbIcon,
                      height: 22.h,
                      width: 22.w,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      IconImage.googleIcon,
                      height: 22.h,
                      width: 22.w,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      IconImage.appleIcon,
                      height: 22.h,
                      width: 22.w,
                    )),
              ],
            ),
            SizedBox(
                //height: 20.h,
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    color: AppColors.noAccountColor,
                    text: 'Don\'t have an account?',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
                TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, RoutesName.signupEmailPasswordView);
                    },
                    child: CustomText(
                        text: 'SignUp',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
