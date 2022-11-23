import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/data/network/provider_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../images/team_members_images/team_members_images.dart';

class RecentProjects extends StatefulWidget {
  int? stack;
  final DocumentSnapshot snapshot;
  final String proId;
  final void Function(int leftDays) onPressed;

  RecentProjects(
      {Key? key,
      this.stack,
      required this.snapshot,
      required this.proId,
      required this.onPressed})
      : super(key: key);

  @override
  State<RecentProjects> createState() => _RecentProjectsState();
}

class _RecentProjectsState extends State<RecentProjects> {
  String title = '';
  String description = '';
  String date = '';
  int leftdate = 0;
  late DateTime projectDate;
  var notifier = ValueNotifier<int>(0);
  late ProviderServices provider;
  var complete = 0;
  var inComplete = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<ProviderServices>(context, listen: false);
    title = widget.snapshot['title'];
    description = widget.snapshot['description'];
    date = widget.snapshot['last_date'];
    if (date.isNotEmpty) {
      var format = DateFormat("dd-MM-yyyy");
      projectDate = format.parse(date);
      notifier.value = getDate(projectDate, DateTime.now());
    } else {
      projectDate = DateTime.now();
    }
    getPercentage();
  }

  getPercentage() async {
    await provider.updateCompleteList(widget.proId);
    await provider.updateInCompleteList(widget.proId);
    provider.calculatePercentage();
  }

  int getDate(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round().abs();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed(notifier.value);
      },
      child: Consumer<ProviderServices>(
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.only(
              top: 10.h,
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: title,
                        color: AppColors.whiteColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('projects')
                                    .doc(widget.proId)
                                    .delete();
                              },
                              child: CustomText(
                                  text: 'delete',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500))
                        ];
                      },
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.more_vert,
                        color: AppColors.whiteColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 200.w,
                  child: CustomText(
                      textAlign: TextAlign.start,
                      text: description,
                      color: AppColors.whiteColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomText(
                          text:
                              "${value.complete}/${value.inComplete + value.complete}",
                          color: AppColors.whiteColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    // SizedBox(
                    //   width: 80.w,
                    // ),
                    Expanded(
                      child: ValueListenableBuilder<int>(
                          valueListenable: notifier,
                          builder: (context, value, child) {
                            return CustomText(
                                text: "${notifier.value.toString()} Days left",
                                color: AppColors.whiteColor,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w500);
                          }),
                    ),
                    SizedBox(
                      width: 100.w,
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: StepProgressIndicator(
                        totalSteps: (value.complete + value.inComplete) + 1,
                        currentStep: provider.complete + 1,
                        selectedColor: AppColors.whiteColor,
                        unselectedColor: AppColors.blueColor,
                        size: 6.sp,
                        padding: 0.sp,
                        roundedEdges: Radius.circular(5.r),
                      ),
                    ),
                    FixHeightWidth.width35,
                    SizedBox(
                        height: 30.h,
                        width: 75.w,
                        child: const MemeberCircleImage())
                  ],
                )
              ],
            ),
          );
        },
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
