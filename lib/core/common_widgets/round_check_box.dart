import 'package:beta_tasker/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../images/icons/icon_image.dart';

class RoundCheckbox extends StatefulWidget {
  const RoundCheckbox({Key? key}) : super(key: key);

  @override
  State<RoundCheckbox> createState() => _RoundCheckboxState();
}

class _RoundCheckboxState extends State<RoundCheckbox> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isCheck = !isCheck;
        });
      },
      child: Container(
        height: 24.h,
        width: 24.w,
        decoration: BoxDecoration(
            color: isCheck ? AppColors.blueColor : AppColors.whiteColor,
            border:
                Border.all(color: AppColors.recentProjectColor2, width: 2.sp),
            borderRadius: BorderRadius.circular(6.r)),
        child: Center(child: Image.asset(IconImage.checkIcon)),
      ),
    );
  }
}
