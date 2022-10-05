import 'dart:io';

import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../core/app_colors.dart';

class Utils {
  static fieldFocusChange(context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static smoothIndicator(list, pageControler) {
    return SmoothPageIndicator(
      count: list.length,
      controller: pageControler,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.blueColor,
        dotColor: AppColors.dotColor,
        dotWidth: 10.w,
        dotHeight: 10.h,
        expansionFactor: 2,
      ),
    );
  }

  static Future<File> getImage(context) async {
    File? image;
    try {
      final pickFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickFile != null) {
        image = File(pickFile.path);
      }
    } catch (e) {
      displaySnackbar(context, e.toString());
    }
    return image!;
  }

  static displaySnackbar(context, message) {
    var snackBar = SnackBar(
      content: CustomText(
        text: message,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
      backgroundColor: AppColors.roundButtonDarkColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
