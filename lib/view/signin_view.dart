import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/round_button.dart';
import 'package:beta_tasker/core/common_widgets/round_social_button.dart';
import 'package:beta_tasker/core/common_widgets/round_textfield.dart';
import 'package:beta_tasker/images/icons/icon_image.dart';
import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:beta_tasker/utils/utils.dart';
import 'package:beta_tasker/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  var hidePassword = ValueNotifier<bool>(true);
  var checkboxValue = ValueNotifier<bool>(false);
  var emailControler = TextEditingController();
  var passControler = TextEditingController();
  var emailNode = FocusNode();
  var passNode = FocusNode();
  final _authViewModel = AuthViewModel();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor:
    //         AppColors.whiteColor, //or set color with: Color(0xFF0000FF)
    //     statusBarIconBrightness: Brightness.dark));
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
        child: Form(
          key: _formKey,
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
              ValueListenableBuilder<bool>(
                valueListenable: hidePassword,
                builder: (_, value, child) {
                  return RoundTextField(
                      prefixIcon: const Icon(Icons.lock),
                      obsecure: value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          hidePassword.value = !hidePassword.value;
                        },
                        icon: Icon(
                            value ? Icons.visibility_off : Icons.visibility),
                      ),
                      node: passNode,
                      hintText: 'password',
                      controller: passControler);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<bool>(
                      valueListenable: checkboxValue,
                      builder: (_, value, child) {
                        return Checkbox(
                          value: value,
                          onChanged: (bValue) {
                            checkboxValue.value = bValue!;
                          },
                          side: BorderSide(color: Colors.blue, width: 2.w),
                        );
                      }),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _authViewModel.emailPassLogin(
                          emailControler.text.trim(),
                          passControler.text.trim(),
                          context);
                    }
                  }),
              SizedBox(
                height: 10.h,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.forgetPasswordView);
                  },
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
                  RoundSocialButton(
                    onPressed: () async {
                      await _authViewModel.facebookSignup(context);
                    },
                    image: IconImage.fbIcon,
                  ),
                  RoundSocialButton(
                    onPressed: () async {
                      await _authViewModel.googleSignup(context);
                    },
                    image: IconImage.googleIcon,
                  ),
                  RoundSocialButton(
                    onPressed: () {},
                    image: IconImage.appleIcon,
                  ),
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
                        Navigator.pushNamed(
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
      ),
    );
  }
}
