import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/circle_avatar_image.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/round_button.dart';
import 'package:beta_tasker/core/common_widgets/round_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var nameControler = TextEditingController();
  var userControler = TextEditingController();
  var dateControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();
  var roleControler = TextEditingController();

  var nameNode = FocusNode();
  var userNode = FocusNode();
  var dateNode = FocusNode();
  var emailNode = FocusNode();
  var phoneNode = FocusNode();
  var roleNode = FocusNode();

  var _nameColor = AppColors.roundTextfieldBColor;
  var _userColor = AppColors.roundTextfieldBColor;
  var _dateColor = AppColors.roundTextfieldBColor;
  var _emailColor = AppColors.roundTextfieldBColor;
  var _phoneColor = AppColors.roundTextfieldBColor;
  var _roleColor = AppColors.roundTextfieldBColor;

  final _formKey = GlobalKey<FormState>();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Edit Your Profile',
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.blackColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 18.w, right: 18.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatarImage(),
                  FixHeightWidth.height12,
                  RoundTextField(
                    // fillColor: _nameColor,
                    hintText: 'Fullname',
                    controller: nameControler,
                    node: nameNode,
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(context, nameNode, userNode);
                    },
                  ),
                  FixHeightWidth.height5,
                  RoundTextField(
                    // fillColor: _userColor,
                    hintText: 'Username',
                    controller: userControler,
                    node: userNode,
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(context, userNode, dateNode);
                    },
                  ),
                  FixHeightWidth.height5,
                  RoundTextField(
                    // fillColor: _dateColor,
                    hintText: 'Date of birth',
                    controller: dateControler,
                    node: dateNode,
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(context, dateNode, emailNode);
                    },
                  ),
                  FixHeightWidth.height5,
                  RoundTextField(
                    // fillColor: _emailColor,
                    hintText: 'Email',
                    controller: emailControler,
                    node: emailNode,
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(context, emailNode, phoneNode);
                    },
                  ),
                  FixHeightWidth.height5,
                  RoundTextField(
                    // fillColor: _phoneColor,
                    hintText: '+92 312-------',
                    controller: phoneControler,
                    node: phoneNode,
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(context, phoneNode, roleNode);
                    },
                  ),
                  FixHeightWidth.height5,
                  RoundTextField(
                      // fillColor: _roleColor,
                      hintText: 'Role',
                      controller: roleControler,
                      node: roleNode),
                  FixHeightWidth.height40,
                  RoundButton(
                      title: 'Continue',
                      color: AppColors.roundButtonDarkColor,
                      textColor: AppColors.whiteColor,
                      shadowColor: AppColors.roundButtonShadowColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
