import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/circle_avatar_image.dart';
import 'package:beta_tasker/core/common_widgets/common_app_bar.dart';
import 'package:beta_tasker/core/common_widgets/fix_height_width.dart';
import 'package:beta_tasker/core/common_widgets/round_button.dart';
import 'package:beta_tasker/core/common_widgets/round_textfield.dart';
import 'package:beta_tasker/data/network/cloud_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/utils.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
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

  // var _nameColor = AppColors.roundTextfieldBColor;
  // var _userColor = AppColors.roundTextfieldBColor;
  // var _dateColor = AppColors.roundTextfieldBColor;
  // var _emailColor = AppColors.roundTextfieldBColor;
  // var _phoneColor = AppColors.roundTextfieldBColor;
  // var _roleColor = AppColors.roundTextfieldBColor;

  final _formKey = GlobalKey<FormState>();

  String url = '';
  late AnimationController _controller;
  bool shimmmerAffect = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    getData();
  }

  getData() async {
    url = await CloudDataService.createUserData();
    setState(() {});
  }

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
                  CircleAvatarImage(
                    imagePath: url,
                  ),
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              useSafeArea: true,
                              context: context,
                              builder: (_) {
                                return Center(
                                  child: SpinKitFadingCircle(
                                    color: AppColors.whiteColor,
                                    controller: _controller,
                                  ),
                                );
                              });
                          await CloudDataService.insertData(
                                  nameControler.text.trim(),
                                  userControler.text.trim(),
                                  dateControler.text.trim(),
                                  emailControler.text.trim(),
                                  phoneControler.text.trim(),
                                  roleControler.text.trim())
                              .then((value) {
                            Navigator.of(context, rootNavigator: true).pop();
                            Utils.displaySnackbar(
                                context, 'Data saved successfully');
                          });
                          //_formKey.currentState!.reset();
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
