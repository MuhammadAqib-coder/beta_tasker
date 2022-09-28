import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/round_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.todayTaskShadowColor,
                offset: Offset(0.sp, 5.sp),
                blurRadius: 5.r)
          ]),
      child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 28.w),
          title: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CustomText(
                text: 'User Journey',
                color: AppColors.blackColor,
                fontSize: 20.sm,
                fontWeight: FontWeight.w700),
          ),
          subtitle: CustomText(
              text: 'Today - 02:00 PM',
              color: AppColors.subTitleColor,
              fontSize: 14.sm,
              fontWeight: FontWeight.w400),
          trailing: const RoundCheckbox()),
    );
  }
}
