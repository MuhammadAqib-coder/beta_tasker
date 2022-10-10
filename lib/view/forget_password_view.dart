import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/round_button.dart';
import 'package:beta_tasker/core/common_widgets/round_textfield.dart';
import 'package:beta_tasker/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_colors.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _emailControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var emailNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: 'Forget Password',
          icon: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.blackColor,
              ))),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          height: 200.h,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                    color: AppColors.roundButtonShadowColor,
                    blurRadius: 10.r,
                    offset: Offset(0.w, -5.h)),
                BoxShadow(
                    color: AppColors.roundButtonShadowColor,
                    blurRadius: 10.r,
                    offset: Offset(0.w, 5.h))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Form(
                key: _formKey,
                child: RoundTextField(
                  prefixIcon: const Icon(Icons.alternate_email),
                  node: emailNode,
                  hintText: 'Email',
                  controller: _emailControler,
                ),
              ),
              RoundButton(
                  title: 'Send',
                  color: AppColors.roundButtonDarkColor,
                  textColor: AppColors.whiteColor,
                  shadowColor: AppColors.roundButtonShadowColor,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      AuthViewModel()
                          .resetPassword(_emailControler.text.trim(), context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
