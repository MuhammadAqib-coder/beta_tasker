import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../images/splash_image/splash_image.dart';
import '../app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  Widget? icon;
  Widget? action;
  String? image;

  CommonAppBar(
      {Key? key, required this.title, this.icon, this.action, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          icon != null
              ? Container()
              : image != null
                  ? Image.asset(
                      SplashImage.splash,
                      height: 20.h,
                      width: 20.w,
                    )
                  : Container(),
          SizedBox(width: 10.w),
          CustomText(
              style: 'inter',
              text: title,
              color: AppColors.blackColor,
              fontSize: 20.sm,
              fontWeight: FontWeight.w600)
        ],
      ),
      leading: icon,
      actions: [action != null ? action! : Container()],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size.fromHeight(60.h);
  }
}
