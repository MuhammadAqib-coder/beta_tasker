import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayTaskView extends StatefulWidget {
  const TodayTaskView({Key? key}) : super(key: key);

  @override
  State<TodayTaskView> createState() => _TodayTaskViewState();
}

class _TodayTaskViewState extends State<TodayTaskView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Today Tasker',
          icon: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.blackColor,
              )),
        ),
        backgroundColor: AppColors.whiteSmokeColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
          ),
          child: Column(
            children: [
              // const LogoText(
              // ),
              // FixHeight(height: 23),
              // CustomText(
              //     text: 'Today Task',
              //     fontSize: 20.sm,
              //     fontWeight: FontWeight.w600,
              //     style: 'inter'),
              FixHeightWidth.height15,
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 24.w, bottom: 14.h),
                      child: const Task(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
