import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/task.dart';
import 'package:beta_tasker/data/network/cloud_data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayTaskView extends StatefulWidget {
  const TodayTaskView({Key? key}) : super(key: key);

  @override
  State<TodayTaskView> createState() => _TodayTaskViewState();
}

class _TodayTaskViewState extends State<TodayTaskView>
    with TickerProviderStateMixin {
  late TabController _controler;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controler = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: AppColors.blackColor),
          title: CustomText(
            color: AppColors.blackColor,
            text: 'My Tasks',
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            style: 'inter',
          ),
          bottom: TabBar(
              // padding: EdgeInsets.only(left: 5.w, right: 3.w),
              //indicatorPadding: EdgeInsets.all(5.h),
              // labelPadding: EdgeInsets.symmetric(horizontal: 3.w),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: AppColors.blueColor,
              controller: _controler,
              labelColor: AppColors.whiteColor,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.blueColor),
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.transparent;
                } else {
                  return Colors.white;
                }
              }),
              tabs: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.blueColor)),
                  child: Center(
                    child: Tab(
                      height: 30.h,
                      child: CustomText(
                          style: 'inter',
                          text: 'Completed',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.blueColor)),
                  child: Center(
                    child: Tab(
                      height: 30.h,
                      child: CustomText(
                          style: 'inter',
                          text: 'InCompleted',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ]),
        ),
        backgroundColor: AppColors.whiteSmokeColor,
        body: TabBarView(
            controller: _controler, children: [MyTasks1(), MyTasks2()]),
      ),
    );
  }
}

class MyTasks1 extends StatelessWidget {
  const MyTasks1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: StreamBuilder<QuerySnapshot>(
        stream: CloudDataService.getCompleteTaskStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Task(
                    complete: snapshot.data!.docs[index]['is_completed'],
                    docId: snapshot.data!.docs[index].id,
                    date: snapshot.data!.docs[index]['date'],
                    time: snapshot.data!.docs[index]['time'],
                    title: snapshot.data!.docs[index]['title'],
                    onPressed: () {},
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyTasks2 extends StatelessWidget {
  const MyTasks2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: StreamBuilder<QuerySnapshot>(
        stream: CloudDataService.getIncompleteTaskStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Task(
                    priority: snapshot.data!.docs[index]['priority'],
                    complete: snapshot.data!.docs[index]['is_completed'],
                    docId: snapshot.data!.docs[index].id,
                    date: snapshot.data!.docs[index]['date'],
                    time: snapshot.data!.docs[index]['time'],
                    title: snapshot.data!.docs[index]['title'],
                    onPressed: () {},
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
