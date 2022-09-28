import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/images/icons/icon_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: ClipRRect(
          child: Image.asset(
        IconImage.googleIcon,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      )),
      title: CustomText(
          text: 'Website Project',
          fontSize: 18.sm,
          fontWeight: FontWeight.w600),
      subtitle: CustomText(
          text: 'Leave a comment on web design',
          fontSize: 18.sm,
          fontWeight: FontWeight.w600),
      trailing: TextButton(
        onPressed: () {},
        child: CustomText(
          text: 'View',
          fontSize: 14.sm,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
