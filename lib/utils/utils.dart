import 'dart:io';

import 'package:beta_tasker/core/common_widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  static Future<String> getImage(context) async {
    //File? image;
    var storage = FirebaseStorage.instance;
    var fileName = FirebaseAuth.instance.currentUser!.uid;
    String image = '';
    try {
      final pickFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickFile != null) {
        showDialog(
            context: context,
            builder: (_) {
              return Center(
                child: CustomText(
                  color: AppColors.whiteColor,
                  text: "Please wait...",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              );
            });
        image = pickFile.path;
        await storage.ref('ProfileImage/$fileName').putFile(File(image));

        await storage
            .ref('ProfileImage/$fileName')
            .getDownloadURL()
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'image_url': value});
        });
        Navigator.of(context, rootNavigator: true).pop();
      }
    } on FirebaseException catch (e) {
      displaySnackbar(context, e.toString());
    } catch (e) {
      displaySnackbar(context, e.toString());
    }
    return image;
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
