import 'package:beta_tasker/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../images/icons/icon_image.dart';

class RoundSocialButton extends StatelessWidget {
  const RoundSocialButton(
      {Key? key, required this.onPressed, required this.image})
      : super(key: key);
  final VoidCallback onPressed;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColors.whiteColor, shape: const CircleBorder()),
        onPressed: onPressed,
        child: Image.asset(
          image,
          height: 22.h,
          width: 22.w,
        ));
  }
}
