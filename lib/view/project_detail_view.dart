import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/add_task.dart';
import 'package:beta_tasker/core/common_widgets/task.dart';
import 'package:beta_tasker/data/network/provider_services.dart';
import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../core/common_widgets/custom_text.dart';

class ProjectDetailView extends StatefulWidget {
  const ProjectDetailView(
      {Key? key, required this.proSnapshot, required this.remianingDays})
      : super(key: key);

  final DocumentSnapshot proSnapshot;
  final String remianingDays;

  @override
  State<ProjectDetailView> createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderServices>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          leading: Align(
            alignment: Alignment.topCenter,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.blackColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.whiteSmokeColor,
          centerTitle: true,
          toolbarHeight: 100.h,
          flexibleSpace: SafeArea(
              child: Container(
            margin: EdgeInsets.only(top: 70.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                    style: 'inter',
                    text: '${value.percentage}%',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
                CustomText(
                    style: 'inter',
                    text: "${widget.remianingDays} Days Left",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500)
              ],
            ),
          )),
          title: SizedBox(
            height: 80.h,
            child: CustomText(
              style: 'inter',
              color: AppColors.blackColor,
              text: "Add Task",
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Align(
                alignment: Alignment.topCenter,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.blackColor,
                    )))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('projects')
              .doc(widget.proSnapshot.id)
              .collection('projectTasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Task(
                        provider: value,
                        proId: widget.proSnapshot.id,
                        title: snapshot.data!.docs[index]['title'],
                        date: snapshot.data!.docs[index]['date'],
                        docId: snapshot.data!.docs[index].id,
                        complete: snapshot.data!.docs[index]['is_completed'],
                        onPressed: () {
                          AddTask(
                            proId: widget.proSnapshot.id,
                            snapshot: snapshot.data!.docs[index],
                            taskKey: 'projectTask',
                          ).showAddTask(context);
                        },
                        time: snapshot.data!.docs[index]['time']),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddTask(
              provider: value,
              proId: widget.proSnapshot.id,
              taskKey: 'projectTask',
            ).showAddTask(
              context,
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
