import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:beta_tasker/core/common_widgets/recent_projects.dart';
import 'package:beta_tasker/core/common_widgets/tab_bar_container.dart';
import 'package:beta_tasker/images/splash_image/splash_image.dart';
import 'package:beta_tasker/view/project_detail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProjectView extends StatefulWidget {
  const MyProjectView({Key? key}) : super(key: key);

  @override
  State<MyProjectView> createState() => _MyProjectViewState();
}

class _MyProjectViewState extends State<MyProjectView>
    with TickerProviderStateMixin {
  late TabController tabControler;
  bool tab1 = true;
  bool tab2 = false;
  bool tab3 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabControler = TabController(
      length: 2,
      vsync: this,
    );
    tabControler.addListener(() {
      if (tabControler.indexIsChanging) {
        switch (tabControler.index) {
          case 0:
            tab1 = true;
            tab2 = false;
            tab3 = false;

            break;
          case 1:
            tab2 = true;
            tab1 = false;
            tab3 = false;

            break;
          case 2:
            tab3 = true;
            tab1 = false;
            tab2 = false;

            break;
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30.w,
        toolbarHeight: 70.h,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        title: Row(
          children: [
            Image.asset(
              SplashImage.splash,
              height: 20.h,
              width: 20.w,
            ),
            SizedBox(width: 10.w),
            CustomText(
                text: "My Projects",
                color: AppColors.blackColor,
                fontSize: 20.sm,
                fontWeight: FontWeight.w600)
          ],
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [];
          })
        ],
        bottom: TabBar(
            // isScrollable: false,
            // onTap: (value) {
            //   switch (value) {
            //     case 0:
            //       tab1 = true;
            //       tab2 = false;
            //       tab3 = false;

            //       break;
            //     case 1:
            //       tab2 = true;
            //       tab1 = false;
            //       tab3 = false;

            //       break;
            //     case 2:
            //       tab3 = true;
            //       tab1 = false;
            //       tab2 = false;

            //       break;
            //   }
            //   setState(() {});
            // },
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              } else {
                return Colors.white;
              }
            }),
            controller: tabControler,
            //indicatorPadding: EdgeInsets.all(5),
            labelColor: AppColors.whiteColor,
            indicatorColor: AppColors.whiteColor,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: AppColors.blueColor,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.blueColor),
            tabs: [
              // Tab(
              //         child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           border: Border.all(color: AppColors.blueColor)),
              //       child: Center(
              //         child: Text("To-Do"),
              //       ),
              //     ),
              // child: TabBarContainer(
              //     color: tab1 ? AppColors.blueColor : AppColors.whiteColor,
              //     text: 'To-Do',
              //     border: tab1
              //         ? const Border()
              // ?        : Border.all(color: AppColors.blueColor, width: 1))
              // ),
              Tab(
                  height: 30.h,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.blueColor)),
                    child: const Center(
                      child: Text("Completed"),
                    ),
                  )),
              Tab(
                  height: 30.h,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.blueColor)),
                    child: const Center(
                      child: Text("InProgress"),
                    ),
                  )),
              // Tab(
              //     child: TabBarContainer(
              //         color: tab2 ? AppColors.blueColor : AppColors.whiteColor,
              //         text: 'In Progress',
              //         border: tab2
              //             ? const Border()
              //             : Border.all(color: AppColors.blueColor, width: 1))),
              // Tab(
              //     child: TabBarContainer(
              //         color: tab3 ? AppColors.blueColor : AppColors.whiteColor,
              //         text: 'Completed',
              //         border: tab3
              //             ? const Border()
              //             : Border.all(color: AppColors.blueColor, width: 1)))
            ]),
      ),
      body: TabBarView(
        controller: tabControler,
        children: const [
          MyProject(),
          MyProject(),
        ],
      ),
    );
  }
}

class MyProject extends StatefulWidget {
  const MyProject({Key? key}) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('projects')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: RecentProjects(
                    onPressed: (value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProjectDetailView(
                                    remianingDays: value.toString(),
                                    proSnapshot: snapshot.data!.docs[index],
                                  ))).then((value) => setState(() {}));
                    },
                    proId: snapshot.data!.docs[index].id,
                    snapshot: snapshot.data!.docs[index],
                    stack: 1,
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
