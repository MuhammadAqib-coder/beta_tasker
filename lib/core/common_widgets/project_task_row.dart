import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectTaskRow extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ProjectTaskRow({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            style: 'inter',
            text: text,
            color: AppColors.blackColor,
            fontSize: 18.sm,
            fontWeight: FontWeight.w600),
        TextButton(
            onPressed: onPressed,
            child: CustomText(
              text: 'see All',
              color: AppColors.blueColor,
              fontSize: 14.sm,
              fontWeight: FontWeight.w600,
            ))
      ],
    );
  }
}
