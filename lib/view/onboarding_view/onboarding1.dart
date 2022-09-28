import 'package:beta_tasker/images/onboardingImages/onboarding_images.dart';
import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:beta_tasker/view/introduction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_colors.dart';
import '../../core/common_widgets/custom_text.dart';
import '../../core/common_widgets/round_button.dart';

class OnBoarding1 extends StatelessWidget {
  final PageController pageControler;
  OnBoarding1({
    Key? key,
    required this.pageControler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 470.h,
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              OnboardingImages.onBoarding1,
              height: 200.h,
              width: 332.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
              child: CustomText(
                  textAlign: TextAlign.center,
                  text: "Organize Your Tasks & Project Easy",
                  color: AppColors.blackColor,
                  fontSize: 29.sp,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
              child: CustomText(
                  textAlign: TextAlign.center,
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ullamcorper morbi magna elit hac adipiscing auctor. Eget nisl, donec sed sollicitudin.",
                  color: AppColors.introCenterTextColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400),
            ),
          ]),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 50.h),
          height: 120.h,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundButton(
                title: "Next",
                color: AppColors.roundButtonDarkColor,
                textColor: AppColors.whiteColor,
                shadowColor: AppColors.roundButtonShadowColor,
                onPressed: () {
                  //Navigator.pushNamed(context, RoutesName.onBoardView2);
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (_) => PageBuilder(index: 1)));
                  pageControler.jumpToPage(1);
                },
              ),
              RoundButton(
                title: "Skip",
                color: AppColors.roundButtonLightColor,
                textColor: AppColors.whiteColor,
                shadowColor: AppColors.roundButtonShadowColor,
                onPressed: () {
                  pageControler.jumpToPage(2);
                  // Navigator.pushNamed(context, RoutesName.onBoardView3);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
