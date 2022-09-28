import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/images/splash_image/splash_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoText extends StatelessWidget {
  const LogoText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          SplashImage.splash,
          height: 20.h,
          width: 17.w,
        ),
        SizedBox(width: 10.w),
        CustomText(
            style: 'gilroy',
            text: 'Beta Tasker',
            color: AppColors.logoColor,
            fontSize: 18.sm,
            fontWeight: FontWeight.w800)
      ],
    );
  }
}
