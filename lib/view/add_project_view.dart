import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/round_button.dart';
import 'package:beta_tasker/core/common_widgets/round_textfield.dart';
import 'package:beta_tasker/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProjectView extends StatefulWidget {
  const AddProjectView({Key? key}) : super(key: key);

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  var titleControler = TextEditingController();
  var desControler = TextEditingController();
  var dateControler = TextEditingController();
  var titleNode = FocusNode();
  var desNode = FocusNode();
  var dateNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Add Project',
        icon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.blackColor,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundTextField(
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, titleNode, desNode);
                },
                hintText: 'Title',
                controller: titleControler,
                node: titleNode),
            SizedBox(
              height: 10.h,
            ),
            RoundTextField(
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, desNode, dateNode);
                },
                hintText: 'Description',
                controller: desControler,
                node: desNode),
            SizedBox(
              height: 10.h,
            ),
            RoundTextField(
                hintText: 'last date',
                controller: dateControler,
                node: dateNode),
            SizedBox(
              height: 10.h,
            ),
            RoundButton(
                title: 'Add',
                color: AppColors.roundButtonDarkColor,
                textColor: AppColors.whiteColor,
                shadowColor: AppColors.roundButtonShadowColor,
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('projects')
                      .doc()
                      .set({
                    'title': titleControler.text.trim(),
                    'description': desControler.text.trim(),
                    'last_date': dateControler.text.trim(),
                    'is_complete': false
                  });
                })
          ],
        ),
      ),
    );
  }
}
