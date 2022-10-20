import 'package:beta_tasker/core/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../images/icons/icon_image.dart';

class RoundCheckbox extends StatefulWidget {
  final String docId;
  final bool complete;
  const RoundCheckbox({Key? key, required this.docId, required this.complete}) : super(key: key);

  @override
  State<RoundCheckbox> createState() => _RoundCheckboxState();
}

class _RoundCheckboxState extends State<RoundCheckbox> {
  @override
  Widget build(BuildContext context) {
  var isCheck = ValueNotifier<bool>(widget.complete);

    return InkWell(
      onTap: () async {
        isCheck.value = !isCheck.value;
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(widget.docId)
            .update({'is_completed': isCheck.value});
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: isCheck,
        builder: (_, value, child) {
          return Container(
            height: 24.h,
            width: 24.w,
            decoration: BoxDecoration(
                color: value ? AppColors.blueColor : AppColors.whiteColor,
                border: Border.all(
                    color: AppColors.recentProjectColor2, width: 2.sp),
                borderRadius: BorderRadius.circular(6.r)),
            child: Center(child: Image.asset(IconImage.checkIcon)),
          );
        },
      ),
    );
  }
}
