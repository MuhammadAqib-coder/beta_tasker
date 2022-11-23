import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/recent_projects.dart';
import 'package:beta_tasker/view/project_detail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentProjectsView extends StatefulWidget {
  const RecentProjectsView({Key? key}) : super(key: key);

  @override
  State<RecentProjectsView> createState() => _RecentProjectsViewState();
}

class _RecentProjectsViewState extends State<RecentProjectsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Recent Project',
          icon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: AppColors.blackColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 22.w,
            right: 22.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomText(
              //     style: 'inter',
              //     text: 'Recent Project',
              //     color: AppColors.blackColor,
              //     fontSize: 20.sm,
              //     fontWeight: FontWeight.w600),
              FixHeightWidth.height26,
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('projects')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 13.h),
                            child: RecentProjects(
                              onPressed: (value) {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ProjectDetailView(
                                                proSnapshot:
                                                    snapshot.data!.docs[index],
                                                remianingDays:
                                                    value.toString())))
                                    .then((value) => setState(() {}));
                              },
                              proId: snapshot.data!.docs[index].id,
                              snapshot: snapshot.data!.docs[index],
                              stack: 1,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
