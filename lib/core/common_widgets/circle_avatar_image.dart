import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../images/icons/icon_image.dart';
import '../../images/splash_image/splash_image.dart';
import '../../utils/utils.dart';
import '../app_colors.dart';

class CircleAvatarImage extends StatefulWidget {
  const CircleAvatarImage({Key? key}) : super(key: key);

  @override
  State<CircleAvatarImage> createState() => _CircleAvatarImageState();
}

class _CircleAvatarImageState extends State<CircleAvatarImage> {
  File? image;

  var showImage = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      width: 110.w,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: showImage,
            builder: (_, value, child) {
              return value
                  ? CircleAvatar(
                      backgroundColor: AppColors.avatarColor,
                      backgroundImage: FileImage(File(image!.path).absolute))
                  : const CircleAvatar(
                      backgroundColor: AppColors.avatarColor,
                    );
            },
          ),
          Positioned(
              bottom: 10,
              right: 5,
              child: InkWell(
                onTap: () async {
                  showImage.value = false;
                  image = await Utils.getImage(context);
                  if (image!.path.isEmpty) {
                  } else {
                    //image setting is not cleared
                    //use provider
                    showImage.value = !showImage.value;
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(3.r),
                  height: 15.h,
                  width: 15.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: AppColors.blueColor),
                  child: Image.asset(
                    IconImage.editIcon,
                    height: 6.h,
                    width: 6.w,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
