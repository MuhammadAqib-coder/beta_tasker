import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/notification_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_colors.dart';
import '../core/common_widgets/common_app_bar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: 'Notification',
          action: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.blackColor,
            ),
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 27.w, right: 10.w, top: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "Today", fontSize: 18.sm, fontWeight: FontWeight.w600),
            Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (builder, context) {
                    return NotificationContainer();
                  }),
            ),
            FixHeightWidth.height10,
            CustomText(
                text: "Yesturday",
                fontSize: 18.sm,
                fontWeight: FontWeight.w600),
            Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (builder, context) {
                    return NotificationContainer();
                  }),
            ),
            FixHeightWidth.height10,
            CustomText(
                text: "Today", fontSize: 18.sm, fontWeight: FontWeight.w600),
            Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (builder, context) {
                    return NotificationContainer();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
