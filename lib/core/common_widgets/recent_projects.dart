import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../images/team_members_images/team_members_images.dart';

class RecentProjects extends StatefulWidget {
  int? stack;

  RecentProjects({Key? key, this.stack}) : super(key: key);

  @override
  State<RecentProjects> createState() => _RecentProjectsState();
}

class _RecentProjectsState extends State<RecentProjects> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 18.w,
        right: 12.w,
      ),
      width: 360.w,
      height: 140.h,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            AppColors.recentProjectColor2,
            AppColors.recentProjectColor1,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "Website Project",
                  color: AppColors.whiteColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700),
              const Icon(
                Icons.more_vert,
                color: AppColors.whiteColor,
              )
            ],
          ),
          SizedBox(
            width: widget.stack == 1 ? 250.w : 190.w,
            child: CustomText(
                textAlign: TextAlign.start,
                text: "Landing Page Design - AUG, 22, 2022",
                color: AppColors.whiteColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: widget.stack == 1 ? 32.h : 18.h),
          Row(
            children: [
              CustomText(
                  text: "80/100",
                  color: AppColors.whiteColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400),
              SizedBox(
                width: widget.stack == 1 ? 82.w : 70.w,
              ),
              CustomText(
                  text: "2 Days Left",
                  color: AppColors.whiteColor,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w500),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: StepProgressIndicator(
                  totalSteps: 100,
                  currentStep: 82,
                  selectedColor: AppColors.whiteColor,
                  unselectedColor: AppColors.blueColor,
                  size: 6.sp,
                  padding: 0.sp,
                  roundedEdges: Radius.circular(5.r),
                ),
              ),
              FixHeightWidth.width35,
              SizedBox(
                  height: 30.h, width: 75.w, child: const MemeberCircleImage())
            ],
          )
        ],
      ),
    );
  }
}

class MemeberCircleImage extends StatelessWidget {
  const MemeberCircleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.centerRight,
        children: [
          Positioned(
            left: 0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10.r,
              backgroundImage: AssetImage(TeamMemebersImages.teamImage1),
            ),
          ),
          Positioned(
              left: 12.w,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10.r,
                backgroundImage: AssetImage(TeamMemebersImages.teamImage2),
              )),
          Positioned(
              left: 24.w,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10.r,
                backgroundImage: AssetImage(TeamMemebersImages.teamImage3),
              )),
          Positioned(
              left: 36.w,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10.r,
                backgroundImage: AssetImage(TeamMemebersImages.teamImage4),
              )),
          Positioned(
              left: 48.w,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10.r,
                backgroundImage: AssetImage(TeamMemebersImages.teamImage5),
                child: Center(
                    child: CustomText(
                        text: '+3',
                        color: AppColors.whiteColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400)),
              )),
        ],
      ),
    );
  }
}
