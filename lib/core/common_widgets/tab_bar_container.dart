import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarContainer extends StatelessWidget {
  Color color;
  String text;
  BoxBorder border;
  TabBarContainer(
      {Key? key, required this.color, required this.text, required this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.r),
            border: border),
        child: CustomText(
          text: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          style: 'inter',
        ));
  }
}
