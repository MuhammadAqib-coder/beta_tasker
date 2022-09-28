import 'package:beta_tasker/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          fillColor: AppColors.whiteColor,
          filled: true,
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 16.sp),
          prefixIcon: Icon(Icons.search, size: 22.sp),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(13.r),
          )),
    );
  }
}
