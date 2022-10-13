import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../images/icons/icon_image.dart';
import '../../utils/utils.dart';
import '../app_colors.dart';

class CircleAvatarImage extends StatefulWidget {
  CircleAvatarImage({Key? key, required this.imagePath}) : super(key: key);
  String imagePath;

  @override
  State<CircleAvatarImage> createState() => _CircleAvatarImageState();
}

class _CircleAvatarImageState extends State<CircleAvatarImage> {
  // File? image;
  String image = '';
  // String imagePath = '';

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
          widget.imagePath.isNotEmpty
              ? CircleAvatar(
                  backgroundColor: AppColors.avatarColor,
                  backgroundImage: NetworkImage(widget.imagePath),
                )
              : image.isNotEmpty
                  ? CircleAvatar(
                      backgroundColor: AppColors.avatarColor,
                      backgroundImage: FileImage(File(image)),
                    )
                  : const CircleAvatar(
                      backgroundColor: AppColors.avatarColor,
                    ),
          Positioned(
              bottom: 10,
              right: 5,
              child: InkWell(
                onTap: () async {
                  showImage.value = false;
                  await Utils.getImage(context).then((value) {
                    if (value.isNotEmpty) {
                      image = value;
                      widget.imagePath = '';
                      setState(() {});
                    } else {
                      Utils.displaySnackbar(context, 'No image selected');
                    }
                  });
                  // if (image!.path.isEmpty) {
                  // } else {
                  //   //image setting is not cleared
                  //   //use provider
                  //   // showImage.value = !showImage.value;
                  // }
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
