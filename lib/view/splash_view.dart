import 'dart:async';

import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/images/splash_image/splash_image.dart';
import 'package:beta_tasker/view/create_account_view/signup_option_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3),
            () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignupOptionView()),
        ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(SplashImage.splash,height: 150.h,width: 200.w,)),

          FixHeightWidth.height26,

           Center(
            child: CustomText(text: 'Beta Tasker', fontSize: 35.sm, fontWeight: FontWeight.w800,style: 'gilory',)
          ),


        ],
      ),
    );
  }
}
