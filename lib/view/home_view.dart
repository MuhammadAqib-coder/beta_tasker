import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/project_task_row.dart';
import 'package:beta_tasker/core/common_widgets/recent_projects.dart';
import 'package:beta_tasker/core/common_widgets/search_field.dart';
import 'package:beta_tasker/core/common_widgets/task.dart';
import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _pageControler = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CommonAppBar(
        action: PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text('notification')),
                PopupMenuItem(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Text('Logout'))
              ];
            },
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.blackColor,
            )),
        title: 'Beta Tasker',
        image: 'image',
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 22.w,
              right: 22.w,
            ),
            child: Column(
              children: [
                const SearchField(),
                SizedBox(height: 10.h),
                ProjectTaskRow(
                  text: 'Recent Project',
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.recentProjectView);
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 140.h,
            child: PageView.builder(
              pageSnapping: false,
              controller: _pageControler,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: RecentProjects(),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 10.h),
            child: ProjectTaskRow(
              text: 'Today Task',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.todayTaskView);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Task(),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
