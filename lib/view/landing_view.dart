import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/recent_projects.dart';
import 'package:beta_tasker/images/icons/icon_image.dart';
import 'package:beta_tasker/view/home_view.dart';
import 'package:beta_tasker/view/my_project_view.dart';
import 'package:beta_tasker/view/profile_view.dart';
import 'package:beta_tasker/view/recent_projects_view.dart';
import 'package:beta_tasker/view/today_task_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../core/common_widgets/custom_text.dart';
import 'notification_view.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  var titleControler = TextEditingController();
  var descriptionConreoler = TextEditingController();
  //String priorityText = '';
  var titleNode = FocusNode();
  var isVisible = ValueNotifier<bool>(false);
  var priorityText = ValueNotifier<String>('');

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
              showGeneralDialog(
                  barrierDismissible: false,
                  context: context,
                  transitionDuration: const Duration(milliseconds: 700),
                  pageBuilder: (context, anim1, anim2) => StatefulBuilder(
                        builder: (_, setState) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: WillPopScope(
                              onWillPop: () async => true,
                              child: AlertDialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                scrollable: true,
                                content: Column(children: [
                                  ValueListenableBuilder<bool>(
                                      valueListenable: isVisible,
                                      builder: (context, value, child) {
                                        if (value) {
                                          return priorityContainer(
                                              context, setState);
                                        } else {
                                          return Container();
                                        }
                                      }),
                                  dataContainer(context, setState),
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                          .animate(anim1),
                      child: child,
                    );
                  });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
      body: pages[_currentIndex],
    );
  }

  Container dataContainer(BuildContext context, StateSetter setState) {
    String date = '';
    String time = '';
    String dateTime = '';
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      height: 200.h,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleControler,
            autofocus: true,
            // focusNode: titleNode,
            decoration: const InputDecoration(
                hintText: "e.g. Go to hospital at 5 pm",
                border: InputBorder.none),
          ),
          TextFormField(
            controller: descriptionConreoler,
            decoration: const InputDecoration(
                hintText: "Description", border: InputBorder.none),
          ),
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            firstDate: DateTime(2022),

            lastDate: DateTime(2030),
            //icon: Icon(Icons.event),
            onChanged: (value) {
              var list = value.split(' ');
              for (var i = 0; i < list.length; i++) {
                if (i == 0) {
                  date = list[i];
                  var format = DateFormat().add_yMMMd();
                  date = format.format(DateTime.parse(date));

                  debugPrint(date);
                } else {
                  time = list[i];
                  dateTime = '$date-$time';
                  debugPrint(time);
                }
              }
            },
            onSaved: (value) {
              debugPrint(value);
            },
            decoration: const InputDecoration(
              hintText: 'Time and Date',
              border: InputBorder.none,
              labelText: 'Time and date',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  isVisible.value = !isVisible.value;
                },
                icon: Image.asset(
                  IconImage.priorityIcon,
                  height: 25.h,
                ),
                label: Text(
                  priorityText.value,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('tasks')
                        .doc()
                        .set({
                      'title': titleControler.text.trim(),
                      'description': descriptionConreoler.text.trim(),
                      'date': date,
                      'time': time,
                      'priority': priorityText.value,
                      'is_completed': false,
                    });
                  },
                  icon: Image.asset(
                    IconImage.senIcon,
                    height: 20.h,
                  ))
            ],
          )
        ],
      ),
    );
  }

  AnimatedContainer priorityContainer(
      BuildContext context, StateSetter setState) {
    return AnimatedContainer(
      height: 150.h,
      width: MediaQuery.of(context).size.width * 0.4,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInBack,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: ValueListenableBuilder<String>(
              valueListenable: priorityText,
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    priorityText.value = (index + 1).toString();
                    isVisible.value = !isVisible.value;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 8.r,
                        backgroundColor: index == 0
                            ? Colors.red
                            : index == 1
                                ? Colors.yellow
                                : index == 2
                                    ? Colors.blue
                                    : Colors.grey,
                      ),
                      CustomText(
                          text: "Priority ${index + 1}",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
