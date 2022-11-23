import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/round_check_box.dart';
import 'package:beta_tasker/data/network/provider_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Task extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String docId;
  final bool complete;
  final VoidCallback onPressed;
  String? proId;
  String? priority;
  ProviderServices? provider;
  Task(
      {Key? key,
      required this.title,
      required this.date,
      required this.docId,
      required this.complete,
      required this.onPressed,
      required this.time,
      this.priority = '',
      this.provider,
      this.proId})
      : super(key: key);

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
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 28.w),
        title: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CustomText(
              text: widget.title,
              color: AppColors.blackColor,
              fontSize: 20.sm,
              fontWeight: FontWeight.w700),
        ),
        subtitle: CustomText(
            text: "${widget.date} - ${widget.time}",
            color: AppColors.subTitleColor,
            fontSize: 14.sm,
            fontWeight: FontWeight.w400),
        trailing: RoundCheckbox(
          priority: widget.priority!,
          complete: widget.complete,
          docId: widget.docId,
          proId: widget.proId,
          provider: widget.provider,
        ),
        onTap: widget.onPressed,
      ),
    );
  }
}
