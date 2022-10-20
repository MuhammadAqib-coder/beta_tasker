
import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/add_task.dart';
import 'package:beta_tasker/images/icons/icon_image.dart';
import 'package:beta_tasker/view/home_view.dart';
import 'package:beta_tasker/view/my_project_view.dart';
import 'package:beta_tasker/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notification_view.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  var pages = const [
    HomeView(),
    MyProjectView(),
    NotificationView(),
    ProfileView()
  ];
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          toolbarHeight: 0.sp,
          elevation: 0.sp,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: AppColors.whiteColor)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.blueColor,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                IconImage.selectedHometIcon,
                height: 18.h,
                width: 18.w,
              ),
              icon: Image.asset(
                IconImage.homeIcon,
                height: 20.h,
                width: 20.w,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                IconImage.selectedProjectIcon,
                height: 18.h,
                width: 18.w,
              ),
              icon: Image.asset(
                IconImage.projectIcon,
                height: 18.h,
                width: 18.w,
              ),
              label: 'Project'),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.notifications_active,
                size: 18.h,
              ),
              icon: Icon(
                Icons.notifications_active_outlined,
                size: 18.h,
                color: AppColors.navigationLabelColor,
              ),
              label: 'Notification'),
          BottomNavigationBarItem(
              activeIcon: const Icon(Icons.person),
              icon: Image.asset(
                IconImage.profileIcon,
                height: 18.h,
                width: 18.w,
              ),
              label: 'Profile'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 35.h),
          child: FloatingActionButton(
            onPressed: () {
              AddTask().showAddTask(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
      body: pages[_currentIndex],
    );
  }

  // var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  // Random _rnd = Random();
  // String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
  //     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
